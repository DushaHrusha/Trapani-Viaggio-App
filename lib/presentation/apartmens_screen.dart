import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/bloc/cubits/apartments_cubit.dart';
import 'package:test_task/bloc/state/apartments_state.dart';
import 'package:test_task/core/adaptive_size_extension.dart';
import 'package:test_task/core/constants/bottom_bar.dart';
import 'package:test_task/core/constants/grey_line.dart';
import 'package:test_task/presentation/apartmens_detail_screen.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/custom_app_bar.dart';
import 'package:test_task/core/constants/custom_background_with_gradient.dart';
import 'package:test_task/core/constants/second_card.dart';
import 'package:test_task/presentation/main_menu_screen.dart';
import 'package:test_task/presentation/profile_screen.dart';
import 'package:test_task/presentation/splash_screen.dart';

class ApartmensScreen extends StatefulWidget {
  const ApartmensScreen({super.key});

  @override
  createState() => _ApartmensListState();
}

class _ApartmensListState extends State<ApartmensScreen>
    with SingleTickerProviderStateMixin {
  final Map<int, int> ratings = {};

  // Контроллеры анимации
  late AnimationController _animationController;
  late Animation<double> _appBarOpacityAnimation;
  late Animation<Offset> _bottomBarSlideAnimation;
  late Animation<double> _cardsOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _appBarOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.5, curve: Curves.easeInOut),
      ),
    );
    _cardsOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 1, curve: Curves.easeInOut),
      ),
    );
    _bottomBarSlideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 0.7, curve: Curves.easeOutQuad),
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
    return BlocProvider(
      create: (context) => ApartmentsCubit()..loadExcursions(),
      child: Scaffold(
        backgroundColor: BaseColors.background,
        body: BlocBuilder<ApartmentsCubit, ApartmentsState>(
          builder: (context, state) {
            if (state is ApartmentsInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ApartmentsLoaded) {
              return CustomBackgroundWithGradient(
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: _appBarOpacityAnimation,
                      child: CustomAppBar(label: "apartments"),
                    ),
                    FadeTransition(
                      opacity: _appBarOpacityAnimation,
                      child: GreyLine(),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 32,
                        ),
                        itemCount: state.apartments.length,
                        itemBuilder: (context, index) {
                          final apartment = state.apartments[index];
                          return FadeTransition(
                            opacity: _cardsOpacityAnimation,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ApartmentsDetailScreen(
                                          apartments: apartment,
                                        ),
                                  ),
                                );
                              },
                              child: SecondCard(
                                index: index,
                                data: apartment,
                                context: context,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "SF Pro Display",
                                  color: BaseColors.accent,
                                  fontSize: 21,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(child: Text('Error loading excursions'));
          },
        ),
        // Анимированный BottomBar со slide
        bottomNavigationBar: SlideTransition(
          position: _bottomBarSlideAnimation,
          child: BottomBar(currentScreen: widget),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SlideTransition(
          position: _bottomBarSlideAnimation,
          child: Container(
            margin: EdgeInsets.only(bottom: 30),
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
                child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: SvgPicture.asset(
                    "assets/file/sliders.svg",
                    color: BaseColors.accent,
                    height: 24,
                  ),
                  onPressed: () => setState(() {}),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Оставляем существующие вспомогательные методы без изменений
  Widget _buildSvgIconButton(String assetPath, VoidCallback onPressed) {
    return IconButton(icon: _buildSafeSvg(assetPath), onPressed: onPressed);
  }

  Widget _buildSafeSvg(String assetPath) {
    try {
      return SvgPicture.asset(
        assetPath,
        width: context.adaptiveSize(24),
        height: context.adaptiveSize(24),
        colorFilter: ColorFilter.mode(BaseColors.text, BlendMode.srcIn),
        placeholderBuilder:
            (BuildContext context) => Icon(
              Icons.error_outline,
              color: Colors.red,
              size: context.adaptiveSize(24),
            ),
      );
    } catch (e) {
      print('SVG Loading Error for $assetPath: $e');
      return Icon(
        Icons.error_outline,
        color: Colors.red,
        size: context.adaptiveSize(24),
      );
    }
  }

  void _navigateToScreen(int index) {
    Widget targetScreen;
    switch (index) {
      case 0:
        targetScreen = MainMenuScreen();
        break;
      case 1:
        targetScreen = SplashScreen();
        break;
      case 2:
        targetScreen = SplashScreen();
        break;
      case 3:
        targetScreen = ProfileScreen();
        break;
      default:
        targetScreen = SplashScreen();
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (_, __, ___) => targetScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: FadeTransition(
              opacity: Tween<double>(
                begin: 1.0,
                end: 0.0,
              ).animate(secondaryAnimation),
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 =
        Paint()
          ..color = const Color.fromARGB(255, 255, 255, 255)
          ..style = PaintingStyle.fill
          ..strokeWidth = size.width * 0.00
          ..strokeCap = StrokeCap.butt
          ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0010000, 0);
    path_0.lineTo(size.width * -0.0040000, size.height * 0.6980000);
    path_0.quadraticBezierTo(
      size.width * 0.3485200,
      size.height * 0.7002200,
      size.width * 0.3998600,
      size.height * 0.6994400,
    );
    path_0.cubicTo(
      size.width * 0.4492500,
      size.height * 0.6775000,
      size.width * 0.4259900,
      size.height * 0.6563600,
      size.width * 0.4992800,
      size.height * 0.6253600,
    );
    path_0.cubicTo(
      size.width * 0.5661600,
      size.height * 0.6528200,
      size.width * 0.5507400,
      size.height * 0.6780800,
      size.width * 0.6002000,
      size.height * 0.6986800,
    );
    path_0.quadraticBezierTo(
      size.width * 0.6510000,
      size.height * 0.6975000,
      size.width * 1.0010000,
      size.height * 0.6940000,
    );
    path_0.lineTo(size.width * 0.9990000, size.height * -0.0060000);

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 =
        Paint()
          ..color = const Color.fromARGB(255, 33, 150, 243)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0
          ..strokeCap = StrokeCap.square
          ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
