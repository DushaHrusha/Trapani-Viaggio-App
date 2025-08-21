import 'dart:math';

import 'package:flutter/material.dart';

class HexagonLayout extends StatefulWidget {
  const HexagonLayout({super.key});

  @override
  _HexagonLayoutState createState() => _HexagonLayoutState();
}

class _HexagonLayoutState extends State<HexagonLayout>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final List<String> _labels = [
    'Apartment',
    'Auto',
    'Moto',
    'Bicycle',
    'Vespa',
    'Excursion',
    'What are you looking for?',
  ];
  final List<IconData> _icons = [
    Icons.apartment,
    Icons.directions_car,
    Icons.motorcycle,
    Icons.pedal_bike,
    Icons.moped,
    Icons.tour,
    Icons.search,
  ];
  final Color paleBlue = Color(0xFFB3E5FC);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.shortestSide * 0.15;
    final center = Offset(size * 2, size * 2);
    final radius = size * 1.2;

    return Center(
      child: SizedBox(
        width: size * 4,
        height: size * 4,
        child: Stack(
          children: List.generate(7, (index) {
            final angle = index == 6 ? 0.0 : (index * 60 - 90) * (pi / 180);
            final offset = index == 6
                ? center
                : Offset(
                    center.dx + radius * cos(angle),
                    center.dy + radius * sin(angle),
                  );

            return Positioned(
              left: offset.dx - size / 2,
              top: offset.dy - size / 2,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Interval(index * 0.1, 1.0, curve: Curves.easeOut),
                  ),
                ),
                child: index == 6
                    ? _buildCenterCircle(size)
                    : _buildRegularCircle(size, index),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildRegularCircle(double size, int index) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: paleBlue, shape: BoxShape.circle),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_icons[index], color: Colors.blue, size: size * 0.3),
          SizedBox(height: size * 0.05),
          Text(
            _labels[index],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size * 0.15,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: CustomPaint(
        painter: DashedCirclePainter(),
        child: Center(
          child: Text(
            _labels[6],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size * 0.15,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..strokeCap = StrokeCap.round;

    double dashWidth = 5, dashSpace = 5, radius = size.width / 2;
    double startAngle = 0;

    while (startAngle < 2 * pi) {
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: radius,
        ),
        startAngle,
        dashWidth / radius,
        false,
        paint,
      );
      startAngle += (dashWidth + dashSpace) / radius;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
