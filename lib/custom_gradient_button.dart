import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 56,
        margin: EdgeInsets.symmetric(horizontal: 30),
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
          'Services',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: "SF Pro Display",
          ),
        ),
      ),
    );
  }
}
