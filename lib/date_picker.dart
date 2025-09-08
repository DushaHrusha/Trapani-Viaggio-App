import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? selectedDate1;
  DateTime? selectedDate2;
  String _selectedDateRange1 = '--/--/----'; // Инициализация плейсхолдера
  String _selectedDateRange2 = '--/--/----'; // Инициализация плейсхолдера
  double _minPrice = 40;
  double _maxPrice = 100;
  final double _absoluteMin = 0;
  final double _absoluteMax = 200;
  Future<void> _selectDate(BuildContext context, int selectedDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        if (selectedDate == 1) {
          _selectedDateRange1 = DateFormat('dd/MM/yyyy').format(picked);
        }
        if (selectedDate == 2) {
          _selectedDateRange2 = DateFormat('dd/MM/yyyy').format(picked);
        }
      });
    }
  }

  void _showDatePickerDialog() {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 319,
          top: 133,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.close,
              size: 32,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        AlertDialog(
          backgroundColor: Color.fromARGB(255, 251, 251, 253),
          contentPadding: EdgeInsets.symmetric(horizontal: 23.0),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 24.0, top: 8.0),
            child: Text(
              'Booking Dates',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                fontFamily: "SF Pro Display",
                color: Color.fromARGB(255, 109, 109, 109),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 27),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Start",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "SF Pro Display",
                          color: Color.fromARGB(255, 109, 109, 109),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context, 1),
                        child: Container(
                          height: 40,
                          width: 119,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                selectedDate1 != null
                                    ? DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(selectedDate1!)
                                    : _selectedDateRange1,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "SF Pro Display",
                                  color: Color.fromARGB(255, 109, 109, 109),
                                ),
                              ),
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 16,
                                color: Color.fromARGB(255, 189, 189, 189),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Finish ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "SF Pro Display",
                          color: Color.fromARGB(255, 109, 109, 109),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context, 2),
                        child: Container(
                          height: 40,
                          width: 119,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                selectedDate2 != null
                                    ? DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(selectedDate2!)
                                    : _selectedDateRange2,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "SF Pro Display",
                                  color: Color.fromARGB(255, 109, 109, 109),
                                ),
                              ),
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 16,
                                color: Color.fromARGB(255, 189, 189, 189),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 48),
              Divider(
                height: 1,
                color: Color.fromARGB(255, 224, 224, 224),
                thickness: 1,
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "SF Pro Display",
                      color: Color.fromARGB(255, 109, 109, 109),
                    ),
                  ),
                  Text(
                    '${_minPrice.toInt()} € — ${_maxPrice.toInt()} €',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      fontFamily: "SF Pro Display",
                      color: Color.fromARGB(255, 109, 109, 109),
                    ),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 1,
                  //  trackGap: 5,
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 8,
                    disabledThumbRadius: 8,
                  ),
                  trackShape: RoundedRectSliderTrackShape(),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                  activeTrackColor: Color.fromARGB(255, 189, 189, 189),
                  inactiveTrackColor: Color.fromARGB(255, 224, 224, 224),
                  thumbColor: const Color.fromARGB(221, 224, 224, 224),
                ),
                child: RangeSlider(
                  values: RangeValues(_minPrice, _maxPrice),
                  min: _absoluteMin,
                  max: _absoluteMax,
                  divisions: (_absoluteMax - _absoluteMin).toInt(),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _minPrice = values.start;
                      _maxPrice = values.end;
                    });
                  },
                  labels: null,
                ),
              ),

              const SizedBox(height: 126),
              Container(
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 127, 80),
                      Color.fromARGB(255, 85, 97, 178),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(
                        127,
                        255,
                        175,
                        175,
                      ), // Начальный цвет градиента
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(-5, -5),
                    ),
                    BoxShadow(
                      color: Color.fromARGB(
                        127,
                        132,
                        147,
                        197,
                      ), // Конечный цвет градиента
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: Text(
                  'Go',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: "SF Pro Display",
                  ),
                ),
              ),
              const SizedBox(height: 41),
            ],
          ),
        ),
      ],
    );
  }
}
