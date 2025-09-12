import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/bottom_bar.dart';
import 'package:test_task/core/constants/custom_app_bar.dart';
import 'package:test_task/core/constants/custom_background_with_gradient.dart';
import 'package:test_task/bloc/cubits/excursion_cubit.dart';
import 'package:test_task/presentation/excursion_detail_screen.dart';
import 'package:test_task/bloc/state/excursion_state.dart';
import 'package:test_task/core/constants/first_card.dart';
import 'package:test_task/core/constants/second_card.dart';

class ExcursionsList extends StatefulWidget {
  const ExcursionsList({super.key});

  @override
  createState() => _ExcursionsListState();
}

class _ExcursionsListState extends State<ExcursionsList>
    with SingleTickerProviderStateMixin {
  final Map<int, int> ratings = {};
  final PageController _pageController = PageController();

  // Контроллеры анимации
  late AnimationController _animationController;
  late Animation<double> _appBarOpacityAnimation;
  late Animation<Offset> _bottomBarSlideAnimation;
  late Animation<double> _cardsOpacityAnimation;
  @override
  void initState() {
    super.initState();

    // Инициализация контроллера анимации
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Анимация opacity для AppBar
    _appBarOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.5, curve: Curves.easeInOut),
      ),
    );
    // Анимация opacity для AppBar
    _cardsOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 1, curve: Curves.easeInOut),
      ),
    );
    // Анимация slide для BottomBar
    _bottomBarSlideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Начальная позиция за пределами экрана
      end: Offset.zero, // Конечная позиция
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 0.7, curve: Curves.easeOutQuad),
      ),
    );

    // Запуск анимации
    _animationController.forward();

    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExcursionCubit()..loadExcursions(),
      child: Scaffold(
        backgroundColor: BaseColors.background,
        body: BlocBuilder<ExcursionCubit, ExcursionState>(
          builder: (context, state) {
            if (state is ExcursionInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ExcursionLoaded) {
              return CustomBackgroundWithGradient(
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: _appBarOpacityAnimation,
                      child: CustomAppBar(label: "excursions list"),
                    ),
                    Divider(height: 1, color: Colors.grey[300], thickness: 1),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 32,
                        ),
                        itemCount: state.excursions.length,
                        itemBuilder: (context, index) {
                          final excursion = state.excursions[index];
                          final rating = ratings[index] ?? 0;
                          return FadeTransition(
                            opacity: _cardsOpacityAnimation,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ExcursionDetailScreen(
                                          excursion: excursion,
                                        ),
                                  ),
                                );
                              },
                              child:
                                  (index == 0)
                                      ? FirstCard(
                                        data: excursion,
                                        index: index,
                                        context: context,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "SF Pro Display",
                                          color: BaseColors.accent,
                                          fontSize: 21,
                                        ),
                                      )
                                      : SecondCard(
                                        data: excursion,
                                        context: context,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "SF Pro Display",
                                          color: BaseColors.accent,
                                          fontSize: 21,
                                        ),
                                        index: index,
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
}
