import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/base_colors.dart';
import 'package:test_task/bottom_bar.dart';
import 'package:test_task/car_catalog.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with TickerProviderStateMixin {
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
  final List<String> _svgIcons = [
    'assets/file/keys.svg',
    'assets/file/auto.svg',
    'assets/file/Moto.svg',
    'assets/file/Bicycle.svg',
    'assets/file/Vespa.svg',
    'assets/file/Excursion.svg',
  ];
  late Animation<double> _opacityAnimation;
  late AnimationController _stageController;
  late AnimationController _appBarController;
  late AnimationController _searchController;
  late AnimationController _circlesController;
  late AnimationController _bottomBarController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _bottomBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _bottomBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _bottomBarController,
        curve: const Interval(0.3, 1.0),
      ),
    );
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    ); // Общий контроллер этапов
    _stageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _appBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _searchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _circlesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Запуск последовательности
    _stageController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 23), () {
          _appBarController.forward().then((_) {
            _searchController.forward().then((_) {
              _circlesController.forward().then((_) {
                _controller.forward().then((_) {
                  _bottomBarController.forward();
                });
              });
            });
          });
        });
      }
    });

    _stageController.forward();
  }

  @override
  void dispose() {
    _stageController.dispose();
    _appBarController.dispose();
    _searchController.dispose();
    _circlesController.dispose();
    _bottomBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.shortestSide * 0.25;
    final center = Offset(size * 2, size * 2);
    final radius = size * 1.1;
    return Scaffold(
      backgroundColor: BaseColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(255, 127, 80, 1),
              Color.fromRGBO(85, 97, 178, 1),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 58),
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
              height: MediaQuery.of(context).size.height,
            ),
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _appBarController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _appBarController.value,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 25.0,
                          right: 20,
                          left: 20,
                          bottom: 23,
                        ),
                        child: SizedBox(
                          height: 27,

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back, size: 24),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(
                                  minWidth: 24,
                                  maxHeight: 24,
                                ),
                                onPressed:
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CarCatalog(),
                                      ),
                                    ),
                              ),
                              Align(
                                // Добавлен выравнивающий виджет
                                alignment: Alignment.center,
                                child: Text(
                                  'trapani viaggio',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Berlin Sans FB',
                                    height: 1.0, // Ключевой параметр
                                    color: Color.fromARGB(255, 109, 109, 109),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.menu, size: 24),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(
                                  minWidth: 24,
                                  maxHeight: 24,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Divider(thickness: 1.5, color: BaseColors.line, height: 0),
                AnimatedBuilder(
                  animation: _searchController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _searchController.value,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 48.0,
                          left: 30,
                          right: 28,
                        ),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: BaseColors.background,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: BaseColors.primary,
                              width: 1.0,
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  left: 28,
                                  right: 6,
                                ),
                                child: Align(
                                  // Добавлено выравнивание для иконки
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: SvgPicture.asset(
                                      "assets/file/search.svg",
                                      color: BaseColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                              hintText: 'What do you want to find in Trapani?',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                height: 1.0, // Ключевой параметр
                                fontFamily: 'San Francisco Pro Display',
                                color: BaseColors.primary,
                                fontStyle: FontStyle.italic,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, // Оптимизировано для высоты 40
                                horizontal: 0,
                              ),
                              isDense: true,
                              isCollapsed: true, // Убирает внутренние отступы
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.0, // Единичная высота строки
                            ),
                            maxLines: 1,
                            textAlignVertical:
                                TextAlignVertical
                                    .center, // Центровка по вертикали
                          ),
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _circlesController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _circlesController.value,
                      child: SizedBox(
                        width: size * 4,
                        height: size * 5,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 45.0),
                          child: Stack(
                            children: List.generate(7, (index) {
                              final angle =
                                  index == 6
                                      ? 0.0
                                      : (index * 60 - 90) * (pi / 180);
                              final offset =
                                  index == 6
                                      ? Offset(size * 2 - 4, size * 2 - 4)
                                      : Offset(
                                        center.dx + radius * cos(angle),
                                        center.dy + radius * sin(angle),
                                      );
                              return Positioned(
                                left: offset.dx - size / 2,
                                top: offset.dy - size / 2,
                                child: ScaleTransition(
                                  scale: Tween<double>(
                                    begin: 0,
                                    end: 1,
                                  ).animate(
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
                                          ? _buildCenterCircle(size + 8)
                                          : _buildRegularCircle(size, index),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _bottomBarController,
        builder: (context, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _bottomBarController,
                curve: Curves.easeOut,
              ),
            ),
            child: const BottomBar(),
          );
        },
      ),
    );
  }

  Widget _buildRegularCircle(double size, int index) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: BaseColors.backgroundCircles,
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CarCatalog()),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(_svgIcons[index], color: BaseColors.secondary),
            SizedBox(height: size * 0.01),
            Text(
              _labels[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'San Francisco Pro Display',
                fontSize: size * 0.13,
                color: BaseColors.secondary,
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
                fontFamily: 'San Francisco Pro Display',
                color: BaseColors.accent,
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
          ..color = BaseColors.accent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
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
