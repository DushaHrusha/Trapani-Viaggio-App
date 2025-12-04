import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_task/booking.dart';
import 'package:test_task/booking_service.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/grey_line.dart';
import 'package:test_task/data/models/apartment.dart';

class DatesGuestsScreen extends StatefulWidget {
  final Apartment apartment;
  final Function(DateTime checkIn, DateTime checkOut, int adults, int children)?
  onConfirm;

  const DatesGuestsScreen({super.key, required this.apartment, this.onConfirm});

  @override
  _DatesGuestsScreenState createState() => _DatesGuestsScreenState();
}

class _DatesGuestsScreenState extends State<DatesGuestsScreen> {
  DateTime? selectedCheckIn;
  DateTime? selectedCheckOut;
  int adults = 2;
  int children = 1;

  List<Map<String, String>> bookedDates = [];
  bool isLoadingDates = true;

  @override
  void initState() {
    super.initState();
    _loadBookedDates();
  }

  Future<void> _loadBookedDates() async {
    try {
      final dates = await context.read<ApartmentBookingCubit>().getBookedDates(
        widget.apartment.id,
      );
      setState(() {
        bookedDates = dates;
        isLoadingDates = false;
      });
    } catch (e) {
      setState(() {
        isLoadingDates = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading booked dates')));
    }
  }

  bool _isDateBlocked(DateTime date) {
    for (var booking in bookedDates) {
      final checkIn = DateTime.parse(booking['check_in']!);
      final checkOut = DateTime.parse(booking['check_out']!);

      if (date.isAfter(checkIn.subtract(Duration(days: 1))) &&
          date.isBefore(checkOut)) {
        return true;
      }
    }
    return false;
  }

  Future<void> _selectCheckInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      selectableDayPredicate: (DateTime date) {
        return !_isDateBlocked(date);
      },
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: BaseColors.accent,
              onPrimary: Colors.white,
              surface: BaseColors.background,
              onSurface: BaseColors.text,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedCheckIn = picked;
        // Сбрасываем check-out если он раньше нового check-in
        if (selectedCheckOut != null && selectedCheckOut!.isBefore(picked)) {
          selectedCheckOut = null;
        }
      });
    }
  }

  Future<void> _selectCheckOutDate(BuildContext context) async {
    if (selectedCheckIn == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select check-in date first')),
      );
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedCheckIn!.add(Duration(days: 1)),
      firstDate: selectedCheckIn!.add(Duration(days: 1)),
      lastDate: DateTime.now().add(Duration(days: 365)),
      selectableDayPredicate: (DateTime date) {
        // Проверяем что дата не заблокирована
        if (_isDateBlocked(date)) return false;

        // Проверяем что между check-in и этой датой нет забронированных дат
        for (var booking in bookedDates) {
          final checkIn = DateTime.parse(booking['check_in']!);
          if (checkIn.isAfter(selectedCheckIn!) && checkIn.isBefore(date)) {
            return false;
          }
        }
        return true;
      },
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: BaseColors.accent,
              onPrimary: Colors.white,
              surface: BaseColors.background,
              onSurface: BaseColors.text,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedCheckOut = picked;
      });
    }
  }

  void _incrementAdults() {
    if (adults < 10) {
      setState(() => adults++);
    }
  }

  void _decrementAdults() {
    if (adults > 1) {
      setState(() => adults--);
    }
  }

  void _incrementChildren() {
    if (children < 10) {
      setState(() => children++);
    }
  }

  void _decrementChildren() {
    if (children > 0) {
      setState(() => children--);
    }
  }

  double _calculateTotalPrice() {
    if (selectedCheckIn == null || selectedCheckOut == null) return 0;
    final nights = selectedCheckOut!.difference(selectedCheckIn!).inDays;
    return widget.apartment.price * nights;
  }

  Future<void> _handleBooking() async {
    if (selectedCheckIn == null || selectedCheckOut == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select check-in and check-out dates')),
      );
      return;
    }

    try {
      // Показываем loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      // Проверяем доступность
      final isAvailable = await context
          .read<ApartmentBookingCubit>()
          .checkAvailability(
            apartmentId: widget.apartment.id,
            checkIn: selectedCheckIn!,
            checkOut: selectedCheckOut!,
          );

      // Закрываем loading
      Navigator.pop(context);

      if (!isAvailable) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sorry, these dates are no longer available'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Создаем бронирование
      await context.read<ApartmentBookingCubit>().createBooking(
        apartmentId: widget.apartment.id,
        checkIn: selectedCheckIn!,
        checkOut: selectedCheckOut!,
        adults: adults,
        children: children,
      );

      // Закрываем диалог и вызываем callback
      Navigator.pop(context);

      if (widget.onConfirm != null) {
        widget.onConfirm!(
          selectedCheckIn!,
          selectedCheckOut!,
          adults,
          children,
        );
      }

      // Показываем успешное сообщение
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Booking created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      Navigator.pop(context); // Закрываем loading если есть
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating booking: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final nights =
        selectedCheckIn != null && selectedCheckOut != null
            ? selectedCheckOut!.difference(selectedCheckIn!).inDays
            : 0;
    final totalPrice = _calculateTotalPrice();

    return AlertDialog(
      insetPadding: EdgeInsets.all(0),
      iconPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Color.fromARGB(0, 255, 255, 255),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 314,
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.close, size: 32, color: BaseColors.background),
            ),
          ),
          Container(
            width: 297,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: BaseColors.background,
            ),
            child:
                isLoadingDates
                    ? Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(child: CircularProgressIndicator()),
                    )
                    : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 32),
                        Text(
                          'Dates and Guests',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 109, 109, 109),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24),
                        GreyLine(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 37),

                              // Check-in & Check-out
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Check-in
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Check-in",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                              255,
                                              109,
                                              109,
                                              109,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        GestureDetector(
                                          onTap:
                                              () => _selectCheckInDate(context),
                                          child: Container(
                                            height: 40,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  selectedCheckIn != null
                                                      ? DateFormat(
                                                        'dd/MM/yyyy',
                                                      ).format(selectedCheckIn!)
                                                      : '--/--/----',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromARGB(
                                                      255,
                                                      109,
                                                      109,
                                                      109,
                                                    ),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 16,
                                                  color: Color.fromARGB(
                                                    255,
                                                    189,
                                                    189,
                                                    189,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8),

                                  // Check-out
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Check-out",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                              255,
                                              109,
                                              109,
                                              109,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        GestureDetector(
                                          onTap:
                                              () =>
                                                  _selectCheckOutDate(context),
                                          child: Container(
                                            height: 40,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  selectedCheckOut != null
                                                      ? DateFormat(
                                                        'dd/MM/yyyy',
                                                      ).format(
                                                        selectedCheckOut!,
                                                      )
                                                      : '--/--/----',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromARGB(
                                                      255,
                                                      109,
                                                      109,
                                                      109,
                                                    ),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 16,
                                                  color: Color.fromARGB(
                                                    255,
                                                    189,
                                                    189,
                                                    189,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // Adults
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Adults",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 109, 109, 109),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: _decrementAdults,
                                        icon: Icon(Icons.remove_circle_outline),
                                        color: BaseColors.accent,
                                      ),
                                      Text(
                                        '$adults',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: _incrementAdults,
                                        icon: Icon(Icons.add_circle_outline),
                                        color: BaseColors.accent,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Children
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Children",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 109, 109, 109),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: _decrementChildren,
                                        icon: Icon(Icons.remove_circle_outline),
                                        color: BaseColors.accent,
                                      ),
                                      Text(
                                        '$children',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: _incrementChildren,
                                        icon: Icon(Icons.add_circle_outline),
                                        color: BaseColors.accent,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // Total price
                              if (nights > 0) ...[
                                Divider(
                                  height: 1,
                                  color: Color.fromARGB(255, 224, 224, 224),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '$nights night${nights > 1 ? 's' : ''}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(
                                          255,
                                          109,
                                          109,
                                          109,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${totalPrice.toStringAsFixed(0)} €',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: BaseColors.accent,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24),
                              ],

                              const SizedBox(height: 24),

                              // Book button
                              GestureDetector(
                                onTap: _handleBooking,
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        BaseColors.accent,
                                        BaseColors.primary,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      nights > 0 ? 'Book Now' : 'Select Dates',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }
}

abstract class ApartmentBookingState {}

class ApartmentBookingInitial extends ApartmentBookingState {}

class ApartmentBookingLoading extends ApartmentBookingState {}

class ApartmentBookingSuccess extends ApartmentBookingState {
  final Booking booking;
  ApartmentBookingSuccess(this.booking);
}

class ApartmentBookingError extends ApartmentBookingState {
  final String message;
  ApartmentBookingError(this.message);
}

class ApartmentBookingCubit extends Cubit<ApartmentBookingState> {
  final BookingService _bookingService;

  ApartmentBookingCubit(this._bookingService)
    : super(ApartmentBookingInitial());

  Future<List<Map<String, String>>> getBookedDates(int apartmentId) async {
    try {
      return await _bookingService.getBookedDates(apartmentId);
    } catch (e) {
      throw Exception('Failed to load booked dates: $e');
    }
  }

  Future<bool> checkAvailability({
    required int apartmentId,
    required DateTime checkIn,
    required DateTime checkOut,
  }) async {
    try {
      return await _bookingService.checkAvailability(
        apartmentId: apartmentId,
        checkIn: checkIn,
        checkOut: checkOut,
      );
    } catch (e) {
      throw Exception('Failed to check availability: $e');
    }
  }

  Future<void> createBooking({
    required int apartmentId,
    required DateTime checkIn,
    required DateTime checkOut,
    required int adults,
    required int children,
  }) async {
    emit(ApartmentBookingLoading());

    try {
      final booking = await _bookingService.createBooking(
        apartmentId: apartmentId,
        checkIn: checkIn,
        checkOut: checkOut,
        adults: adults,
        children: children,
      );

      emit(ApartmentBookingSuccess(booking));
    } catch (e) {
      emit(ApartmentBookingError(e.toString()));
      rethrow;
    }
  }
}
