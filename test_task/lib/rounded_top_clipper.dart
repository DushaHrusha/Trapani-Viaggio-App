import 'package:flutter/material.dart';

class RoundedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 40); // Start at the top-left corner with a curve
    path.quadraticBezierTo(0, 0, 40, 0); // Curve to the top
    path.lineTo(size.width - 40, 0); // Straight line to the top-right corner
    path.quadraticBezierTo(size.width, 0, size.width, 40); // Curve to the right
    path.lineTo(size.width, size.height); // Straight line to the bottom
    path.lineTo(0, size.height); // Straight line to the bottom-left corner
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
