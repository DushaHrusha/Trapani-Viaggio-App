import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _lightSpread;
  late Animation<double> _iconScale;
  late Animation<Offset> _textSlide;
  late Animation<double> _subtitleFade;
  late Animation<double> _subtitleFade1;
  late Animation<double> _subtitleFade2;
  final Color _blueLight = Color.fromARGB(232, 36, 36, 130);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Animation setup
    _lightSpread = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.4, curve: Curves.easeOut),
    );

    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.7, curve: Curves.elasticOut),
      ),
    );

    _textSlide = Tween<Offset>(begin: Offset(-0.5, 0.0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(0.5, 0.8, curve: Curves.easeOutBack),
          ),
        );
    _subtitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.7, 1, curve: Curves.easeIn),
      ),
    );
    _subtitleFade1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 0.7, curve: Curves.easeIn),
      ),
    );
    _subtitleFade2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.1, 0.4, curve: Curves.easeIn),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Blue light spread effect
                CustomPaint(
                  painter: _LightPainter(
                    radius:
                        MediaQuery.of(context).size.width * _lightSpread.value,
                    color: _blueLight.withOpacity(0.3),
                  ),
                  size: Size.infinite,
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FadeTransition(
                          opacity: _subtitleFade1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 0,
                            ),
                            child: Text(
                              'trpani',
                              style: TextStyle(
                                fontSize: 36,
                                fontFamily: 'Berlin Sans FB',
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 127, 80, 1),
                              ),
                            ),
                          ),
                        ),
                        FadeTransition(
                          opacity: _subtitleFade2,
                          child: SvgPicture.asset(
                            'assets/file/Logo.svg', // Используйте ваше SVG-изображение
                            height: 50, // Установите высоту
                          ),
                        ),

                        // Subtitle

                        // Right text
                        FadeTransition(
                          opacity: _subtitleFade1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 0,
                            ),
                            child: Text(
                              'viaggio',
                              style: TextStyle(
                                fontFamily: 'Berlin Sans FB',
                                fontSize: 36,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 127, 80, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Icon with subtitle
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: FadeTransition(
                        opacity: _subtitleFade,
                        child: Text(
                          'tourists assistance',
                          style: TextStyle(
                            fontFamily: 'Berlin Sans FB',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LightPainter extends CustomPainter {
  final double radius;
  final Color color;

  _LightPainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(size.center(Offset.zero), radius, paint);
  }

  @override
  bool shouldRepaint(covariant _LightPainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.color != color;
  }
}
