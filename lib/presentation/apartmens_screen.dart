import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/cubits/apartments_cubit.dart';
import 'package:test_task/bloc/state/apartments_state.dart';
import 'package:test_task/presentation/apartmens_detail_screen.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/custom_app_bar.dart';
import 'package:test_task/core/constants/custom_background_with_gradient.dart';
import 'package:test_task/core/constants/second_card.dart';

class ApartmensScreen extends StatefulWidget {
  const ApartmensScreen({super.key});

  @override
  createState() => _ApartmensListState();
}

class _ApartmensListState extends State<ApartmensScreen> {
  final Map<int, int> ratings = {};

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
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
                    CustomAppBar(label: "apartments"),
                    Divider(height: 1, color: Colors.grey[300], thickness: 1),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 32,
                        ),
                        itemCount: state.apartments.length,
                        itemBuilder: (context, index) {
                          final apartment = state.apartments[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          ApartmentsDetailScreenDetailScreen(
                                            apartments: apartment,
                                          ),
                                ),
                              );
                            },
                            child: SecondCard(
                              data: apartment,
                              context: context,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: "SF Pro Display",
                                color: BaseColors.accent,
                                fontSize: 21,
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
        bottomNavigationBar: Container(
          height: 64,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                spreadRadius: 5,
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 5.0,
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite_border_outlined),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.account_circle_outlined),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          //  margin: EdgeInsets.only(bottom: 30),
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
                child: Icon(Icons.search, color: BaseColors.accent, size: 24),
                onPressed: () => setState(() {}),
              ),
            ),
          ),
        ),
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
