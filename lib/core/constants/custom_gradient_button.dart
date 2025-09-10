import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final String text;
  final Widget path;
  const CustomGradientButton({
    super.key,
    required this.text,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => path,
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        height: 56,
        alignment: Alignment.center,
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
          text,
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
