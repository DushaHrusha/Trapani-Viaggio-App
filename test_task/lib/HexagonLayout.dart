import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_task/single_car.dart';

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
  final Color paleBlue = Color.fromARGB(255, 31, 149, 207);

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
    final size = MediaQuery.of(context).size.shortestSide * 0.25;
    final center = Offset(size * 2, size * 2);
    final radius = size * 1.2;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 252, 253),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Color.fromARGB(255, 109, 109, 109),
        ),
        title: const Text(
          'Trapani Viaggio',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 109, 109, 109),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
            color: Color.fromARGB(255, 109, 109, 109),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Divider(height: 1, thickness: 1, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.only(top: 48.0, left: 30, right: 30),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: const Icon(Icons.search, color: Colors.grey),
                  ),
                  hintText: 'What do you want to find in Trapani?',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                ),
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: size * 4,
              height: size * 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 85.0),
                child: Stack(
                  children: List.generate(7, (index) {
                    final angle =
                        index == 6 ? 0.0 : (index * 60 - 90) * (pi / 180);
                    final offset =
                        index == 6
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
                            curve: Interval(
                              index * 0.1,
                              1.0,
                              curve: Curves.easeOut,
                            ),
                          ),
                        ),
                        child:
                            index == 6
                                ? _buildCenterCircle(size)
                                : _buildRegularCircle(size, index),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegularCircle(double size, int index) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 235, 241, 244),
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AutomobileApp()),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _icons[index],
              color: Color.fromARGB(255, 85, 97, 178),
              size: size * 0.3,
            ),
            SizedBox(height: size * 0.05),
            Text(
              _labels[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'San Francisco Pro Display',
                fontSize: size * 0.15,
                color: Color.fromARGB(255, 85, 97, 178),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _labels[6],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size * 0.14,
                color: Color.fromARGB(255, 255, 127, 80),
                fontWeight: FontWeight.w500,
              ),
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
    final paint =
        Paint()
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
