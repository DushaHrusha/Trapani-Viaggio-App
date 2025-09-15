import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/core/adaptive_size_extension.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/custom_gradient_button.dart';
import 'package:test_task/core/routing/app_routes.dart';
import 'package:test_task/presentation/splash_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _appBarOpacityAnimation1;
  late Animation<double> _appBarOpacityAnimation2;
  late Animation<double> _appBarOpacityAnimation3;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _appBarOpacityAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.4, curve: Curves.easeInOut),
      ),
    );
    _appBarOpacityAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.4, 0.6, curve: Curves.easeInOut),
      ),
    );
    _appBarOpacityAnimation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.6, 0.8, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/file/river.jpg',
                  height: context.adaptiveSize(500),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.adaptiveSize(298)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: BaseColors.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(context.adaptiveSize(32)),
                        topRight: Radius.circular(context.adaptiveSize(32)),
                      ),
                    ),
                    constraints: BoxConstraints.expand(
                      width: MediaQuery.of(context).size.width,
                      height:
                          MediaQuery.of(context).size.height -
                          context.adaptiveSize(298),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeTransition(
                            opacity: _appBarOpacityAnimation1,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: context.adaptiveSize(25),
                                top: context.adaptiveSize(25),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  if (Navigator.canPop(context)) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: context.adaptiveSize(24),
                                  color: Color.fromARGB(255, 109, 109, 109),
                                ),
                              ),
                            ),
                          ),
                          // "Sign Up" text
                          FadeTransition(
                            opacity: _appBarOpacityAnimation1,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: context.adaptiveSize(25),
                                top: context.adaptiveSize(17),
                              ),
                              child: Text(
                                'Sign Up',
                                style: context.adaptiveTextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 109, 109, 109),
                                ),
                              ),
                            ),
                          ),
                          // Phone input field with region dropdown
                          FadeTransition(
                            opacity: _appBarOpacityAnimation2,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: context.adaptiveSize(30),
                                top: context.adaptiveSize(24),
                                right: context.adaptiveSize(30),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    context.adaptiveSize(30),
                                  ),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: context.adaptiveSize(100),
                                      height: context.adaptiveSize(50),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(
                                          255,
                                          235,
                                          241,
                                          244,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                            context.adaptiveSize(30),
                                          ),
                                          bottomLeft: Radius.circular(
                                            context.adaptiveSize(30),
                                          ),
                                        ),
                                      ),
                                      child: DropdownButton<String>(
                                        value: '+39',
                                        style: context.adaptiveTextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,

                                          color: BaseColors.text,
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
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    right: context.adaptiveSize(
                                                      8,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,

                                                      color: BaseColors.text,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                        onChanged: (String? newValue) {},
                                        underline: Container(),
                                        icon: SvgPicture.asset(
                                          'assets/file/Vector.svg',
                                          height: context.adaptiveSize(6),
                                          color: BaseColors.text,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: context.adaptiveSize(50),
                                      color: Color.fromARGB(255, 224, 224, 224),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: context.adaptiveSize(50),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(
                                              context.adaptiveSize(30),
                                            ),
                                            bottomRight: Radius.circular(
                                              context.adaptiveSize(30),
                                            ),
                                          ),
                                        ),
                                        child: PhoneNumber(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: context.adaptiveSize(22)),
                          FadeTransition(
                            opacity: _appBarOpacityAnimation2,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Color.fromARGB(255, 224, 224, 224),
                                    indent: context.adaptiveSize(30),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.adaptiveSize(10),
                                  ),
                                  child: Text(
                                    'or',
                                    style: context.adaptiveTextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 224, 224, 224),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Color.fromARGB(255, 224, 224, 224),
                                    endIndent: context.adaptiveSize(30),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: context.adaptiveSize(18)),
                          FadeTransition(
                            opacity: _appBarOpacityAnimation3,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.adaptiveSize(27),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildSocialIcon('assets/file/apple.png'),
                                  _buildSocialIcon('assets/file/google.png'),
                                  _buildSocialIcon('assets/file/facebook.png'),
                                  _buildSocialIcon('assets/file/at sign.png'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: context.adaptiveSize(95)),
                          Padding(
                            padding: context.adaptivePadding(
                              const EdgeInsets.symmetric(horizontal: 30.0),
                            ),
                            child: FadeTransition(
                              opacity: _appBarOpacityAnimation3,
                              child: CustomGradientButton(
                                text: "Sign up",
                                path: "",
                              ),
                            ),
                          ),
                          SizedBox(height: context.adaptiveSize(26)),
                          FadeTransition(
                            opacity: _appBarOpacityAnimation3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Have an account? ',
                                  style: context.adaptiveTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 109, 109, 109),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Log in',
                                    style: context.adaptiveTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: BaseColors.accent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildSocialIcon(String imagePath) {
    return CircleAvatar(
      radius: context.adaptiveSize(24),
      backgroundColor: Color.fromARGB(255, 235, 241, 244),
      child: Image.asset(imagePath),
    );
  }
}

// Остальной код PhoneNumber остается без изменений

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
