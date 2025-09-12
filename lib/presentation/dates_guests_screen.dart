import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_task/presentation/car_catalog.dart';
import 'package:test_task/core/constants/custom_gradient_button.dart';

class DatesGuestsScreen extends StatefulWidget {
  const DatesGuestsScreen({super.key});

  @override
  _DatesGuestsScreenState createState() => _DatesGuestsScreenState();
}

class _DatesGuestsScreenState extends State<DatesGuestsScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 25,
          top: 65,
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
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 0,
          ),
          title: Column(
            children: [
              SizedBox(height: 32),
              Text(
                'Dates and Guests',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  fontFamily: "SF Pro Display",
                  color: Color.fromARGB(255, 109, 109, 109),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Divider(
                height: 1,
                color: Color.fromARGB(255, 224, 224, 224),
                thickness: 1,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 37),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Check-in",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "SF Pro Display",
                          color: Color.fromARGB(255, 109, 109, 109),
                        ),
                      ),
                      SizedBox(height: 10),
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
                        "Check-out",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "SF Pro Display",
                          color: Color.fromARGB(255, 109, 109, 109),
                        ),
                      ),
                      SizedBox(height: 10),
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
              const SizedBox(height: 17),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Guests",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "SF Pro Display",
                          color: Color.fromARGB(255, 109, 109, 109),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 40,
                        width: 119,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "2 adults  ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFamily: "SF Pro Display",
                            color: Color.fromARGB(255, 109, 109, 109),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                              "1 child",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: "SF Pro Display",
                                color: Color.fromARGB(255, 109, 109, 109),
                              ),
                            ),
                          ],
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 71,
                    child: Text(
                      'Price range per night',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: "SF Pro Display",
                        color: Color.fromARGB(255, 109, 109, 109),
                      ),
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
              SizedBox(height: 22),
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 1,
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
              const SizedBox(height: 46),
              CustomGradientButton(text: "Go", path: CarDetailsScreen()),
              const SizedBox(height: 41),
            ],
          ),
        ),
      ],
    );
  }
}
