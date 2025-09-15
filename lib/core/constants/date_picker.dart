import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/custom_gradient_button.dart';
import 'package:test_task/core/constants/grey_line.dart';
import 'package:test_task/core/routing/app_routes.dart';
import 'package:test_task/presentation/sign_up_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(0),
      iconPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Color.fromARGB(0, 255, 255, 255),
      content: Column(
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 32),
                Text(
                  'Booking Dates',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 109, 109, 109),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                GreyLine(),
                SizedBox(height: 37),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
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
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Finish ",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
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
                        ],
                      ),
                      const SizedBox(height: 48),
                      GreyLine(),
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
                              color: Color.fromARGB(255, 109, 109, 109),
                            ),
                          ),
                          Text(
                            '${_minPrice.toInt()} € — ${_maxPrice.toInt()} €',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
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
                          overlayShape: RoundSliderOverlayShape(
                            overlayRadius: 0,
                          ),
                          activeTrackColor: Color.fromARGB(255, 189, 189, 189),
                          inactiveTrackColor: Color.fromARGB(
                            255,
                            224,
                            224,
                            224,
                          ),
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
                      CustomGradientButton(text: "Go", path: "/sign-up"),
                      const SizedBox(height: 41),
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
