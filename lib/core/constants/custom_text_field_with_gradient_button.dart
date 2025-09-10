import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:test_task/presentation/sign_up_screen.dart';

class CustomTextFieldWithGradientButton extends StatelessWidget {
  final String text;
  final TextStyle style;
  const CustomTextFieldWithGradientButton({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(0, 177, 11, 11),
        border: Border.all(
          color: const Color.fromARGB(255, 224, 224, 224),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(text, style: style, textAlign: TextAlign.center),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
            child: Container(
              height: 56,
              width: 190,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 127, 80),
                    Color.fromARGB(255, 85, 97, 178),
                  ],
                  begin: AlignmentGeometry.directional(-2, -3),
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
                    color: Color.fromARGB(127, 132, 147, 197),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Book now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "SF Pro Display",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 56,
                    width: 1,
                    color: const Color.fromARGB(255, 138, 120, 178),
                  ),
                  SizedBox(
                    width: 60,
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
