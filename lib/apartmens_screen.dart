import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/apartmens_detail_screen.dart';
import 'package:test_task/app_cubit.dart';
import 'package:test_task/base_colors.dart';
import 'package:test_task/custom_app_bar.dart';
import 'package:test_task/custom_background_with_gradient.dart';
import 'package:test_task/second_card.dart';

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
                    CustomAppBar(lable: "Apartmens"),
                    Divider(height: 1, color: Colors.grey[300], thickness: 1),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.apartments.length,
                        itemBuilder: (context, index) {
                          final apartments = state.apartments[index];
                          final rating = ratings[index] ?? 0;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => ApartmensDetailScreen(
                                        apartments: apartments,
                                      ),
                                ),
                              );
                            },
                            child: SecondCard(
                              excursion: apartments,
                              rating: rating,
                              index: index,
                              context: context,
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
