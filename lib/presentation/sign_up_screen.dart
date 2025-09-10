import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/core/constants/base_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/file/river.jpg', // Replace with your image path
                    height: 500,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 298),
                  child: Container(
                    decoration: BoxDecoration(
                      color: BaseColors.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32), // Увеличено до 32px
                        topRight: Radius.circular(32),
                      ),
                    ),
                    constraints: BoxConstraints.expand(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 298,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back arrow icon
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 25),
                          child: GestureDetector(
                            onTap: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 24,
                              color: Color.fromARGB(255, 109, 109, 109),
                            ),
                          ),
                        ),
                        // "Sign Up" text
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 17),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color.fromARGB(255, 109, 109, 109),
                              fontSize: 22,
                              fontFamily: 'San Francisco Pro Display',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        // Phone input field with region dropdown
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            top: 24,
                            right: 30,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 235, 241, 244),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                    ),
                                  ),
                                  child: DropdownButton<String>(
                                    value: '+39', // Default value
                                    padding: EdgeInsets.only(left: 28),
                                    style: TextStyle(
                                      fontFamily: 'San Francisco Pro Display',
                                      color: BaseColors.text,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    items:
                                        <String>[
                                          '+39',
                                          '+7',
                                          '+44',
                                          '+91',
                                        ].map<DropdownMenuItem<String>>((
                                          String value,
                                        ) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                right: 8.0,
                                              ),
                                              child: Text(value),
                                            ),
                                          );
                                        }).toList(),
                                    onChanged: (String? newValue) {},
                                    underline:
                                        Container(), // Remove default underline
                                    icon: SvgPicture.asset(
                                      'assets/file/Vector.svg',
                                      height: 6,
                                      color: BaseColors.text,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 50,
                                  color: Color.fromARGB(
                                    255,
                                    224,
                                    224,
                                    224,
                                  ), // Совпадает с цветом внешней рамки
                                ),
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: PhoneNumber(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 22),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Color.fromARGB(255, 224, 224, 224),
                                indent: 30,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'or',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 224, 224, 224),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Color.fromARGB(255, 224, 224, 224),
                                endIndent: 30,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 27.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  235,
                                  241,
                                  244,
                                ),
                                child: Image.asset('assets/file/apple.png'),
                              ),
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  235,
                                  241,
                                  244,
                                ),
                                child: Image.asset('assets/file/google.png'),
                              ),
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  235,
                                  241,
                                  244,
                                ),
                                child: Image.asset('assets/file/facebook.png'),
                              ),
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  235,
                                  241,
                                  244,
                                ),
                                child: Image.asset('assets/file/at sign.png'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 95),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ), // Боковые отступы
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 127, 80),
                                  Color.fromARGB(255, 85, 97, 178),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                // Эффект свечения
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
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: BaseColors.background,
                                  fontSize: 16,
                                  fontFamily: 'San Francisco Pro Display',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 26),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Have an account? ',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'San Francisco Pro Display',
                                color: Color.fromARGB(255, 109, 109, 109),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.orange,
                                  fontFamily: 'San Francisco Pro Display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PhoneNumberState extends State<PhoneNumber> {
  final TextEditingController _phoneController = TextEditingController();
  String _lastText = '';

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_formatPhoneNumber);
  }

  void _formatPhoneNumber() {
    final text = _phoneController.text;
    final cleanText = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Ограничение до 10 цифр
    if (cleanText.length > 10) {
      _phoneController.value = TextEditingValue(
        text: _lastText,
        selection: TextSelection.collapsed(offset: _lastText.length),
      );
      return;
    }

    // Сохранение позиции курсора
    final cursorPosition = _phoneController.selection.baseOffset;
    String formatted = '';

    // Форматирование с сохранением скобок
    if (cleanText.isNotEmpty) {
      if (cleanText.length <= 3) {
        formatted = '($cleanText';
      } else if (cleanText.length <= 6) {
        formatted = '(${cleanText.substring(0, 3)}) ${cleanText.substring(3)}';
      } else if (cleanText.length <= 8) {
        formatted =
            '(${cleanText.substring(0, 3)}) ${cleanText.substring(3, 6)}-${cleanText.substring(6)}';
      } else {
        formatted =
            '(${cleanText.substring(0, 3)}) ${cleanText.substring(3, 6)}-${cleanText.substring(6, 8)}-${cleanText.substring(8)}';
      }
    }

    // Корректировка позиции курсора
    int offsetAdjustment = 0;
    if (cursorPosition > formatted.length) {
      offsetAdjustment = formatted.length;
    } else if (_lastText.length < formatted.length &&
        cursorPosition == _lastText.length) {
      offsetAdjustment = formatted.length;
    } else {
      offsetAdjustment = cursorPosition;
    }

    // Безопасное смещение
    final newOffset = offsetAdjustment.clamp(0, formatted.length);

    _phoneController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newOffset),
    );
    _lastText = formatted;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      controller: _phoneController,
      decoration: InputDecoration(
        hintText: '(000) 000-00-00',
        border: InputBorder.none,
        hintStyle: const TextStyle(
          fontFamily: 'San Francisco Pro Display',
          fontSize: 16,
          color: BaseColors.text,
          fontWeight: FontWeight.w400,
        ),
      ),
      keyboardType: TextInputType.phone,
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}
