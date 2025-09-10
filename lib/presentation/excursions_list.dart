import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/constants/base_colors.dart';
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

class _ExcursionsListState extends State<ExcursionsList> {
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
                    CustomAppBar(label: "excursion"),
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
                          return GestureDetector(
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
                                      rating: rating,
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
          // убрать это
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
