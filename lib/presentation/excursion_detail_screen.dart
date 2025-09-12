import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:test_task/bookmarks.dart';

import 'package:test_task/core/adaptive_size_extension.dart';
import 'package:test_task/core/constants/grey_line.dart';
import 'package:test_task/presentation/apartmens_detail_screen.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/bottom_bar.dart';
import 'package:test_task/core/constants/custom_app_bar.dart';
import 'package:test_task/core/constants/custom_background_with_gradient.dart';
import 'package:test_task/core/constants/custom_text_field_with_gradient_button.dart';
import 'package:test_task/data/models/excursion_model.dart';
import 'package:provider/provider.dart';

class ExcursionDetailScreen extends StatefulWidget {
  final Excursion excursion;

  ExcursionDetailScreen({super.key, required this.excursion});

  @override
  State<ExcursionDetailScreen> createState() => _ExcursionDetailScreenState();
}

class _ExcursionDetailScreenState extends State<ExcursionDetailScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();

  late int displayedIconsCount;

  int _currentPage = 0;

  late List<IconData> icons;

  bool showAllIcons = false;

  late final Excursion _excursion;

  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _appBarOpacityAnimation;
  late Animation<Offset> _bottomBarSlideAnimation;
  late Animation<double> _cardsOpacityAnimation;
  int _currentPage1 = 0;

  @override
  void initState() {
    super.initState();
    _excursion = widget.excursion;

    icons = _excursion.iconServices;
    displayedIconsCount = showAllIcons ? icons.length : 5;

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
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
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildIndicator(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _currentPage == index
                    ? BaseColors.accent
                    : BaseColors.background,
          ),
        );
      }),
    );
  }

  void _scrollRight() {
    setState(() {
      if (_currentPage1 < icons.length - 5) {
        _currentPage1++;
        _scrollController.animateTo(
          _currentPage1 * 80.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _scrollLeft() {
    setState(() {
      if (_currentPage1 > 0) {
        _currentPage1--;
        _scrollController.animateTo(
          _currentPage1 * 80.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackgroundWithGradient(
        child: Column(
          children: [
            FadeTransition(
              opacity: _appBarOpacityAnimation,
              child: CustomAppBar(label: "excursion info"),
            ),
            FadeTransition(opacity: _appBarOpacityAnimation, child: GreyLine()),
            SizedBox(height: 40),
            Expanded(
              child: FadeTransition(
                opacity: _cardsOpacityAnimation,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(context.adaptiveSize(32)),
                              ),
                              child: SizedBox(
                                height: context.adaptiveSize(180),
                                width: MediaQuery.of(context).size.width,
                                child: PageView.builder(
                                  controller: _pageController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _excursion.imageUrl.length,
                                  itemBuilder: (context, index) {
                                    return Image.asset(
                                      _excursion.imageUrl[index],
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              right: context.adaptiveSize(24),
                              top: context.adaptiveSize(24),
                              child: Consumer<BookmarksProvider>(
                                builder: (context, bookmarksProvider, child) {
                                  final isBookmarked = bookmarksProvider
                                      .isBookmarked(_excursion);
                                  return GestureDetector(
                                    onTap: () {
                                      bookmarksProvider.toggleBookmark(
                                        _excursion,
                                      );
                                    },
                                    child: Container(
                                      height: context.adaptiveSize(56),
                                      width: context.adaptiveSize(56),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            context.adaptiveSize(16),
                                          ),
                                        ),
                                        shape: BoxShape.rectangle,
                                        color: Color.fromARGB(
                                          87,
                                          255,
                                          255,
                                          255,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            context.adaptiveSize(16),
                                          ),
                                        ),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 5.0,
                                            sigmaY: 5.0,
                                          ),
                                          child: Icon(
                                            isBookmarked
                                                ? Icons.bookmark
                                                : Icons.bookmark_outline,
                                            color:
                                                isBookmarked
                                                    ? BaseColors.accent
                                                    : Color.fromARGB(
                                                      255,
                                                      251,
                                                      251,
                                                      253,
                                                    ),
                                            size: context.adaptiveSize(25),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: context.adaptiveSize(16),
                              left: 0,
                              right: 0,
                              child: _buildIndicator(
                                _excursion.imageUrl.length,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.adaptiveSize(12)),
                        Text(
                          _excursion.title,
                          softWrap: true,
                          style: context.adaptiveTextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: BaseColors.text,
                            fontFamily: 'San Francisco Pro Display',
                          ),
                        ),
                        SizedBox(height: context.adaptiveSize(16)),
                        Text(
                          _excursion.description,
                          style: context.adaptiveTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 130, 130, 130),
                            fontFamily: 'San Francisco Pro Display',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.adaptiveSize(24)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Duration:",
                              style: context.adaptiveTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: BaseColors.text,
                                fontFamily: 'San Francisco Pro Display',
                              ),
                            ),
                            Text(
                              "${_excursion.duration} hours",
                              style: context.adaptiveTextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: BaseColors.accent,
                                fontFamily: 'San Francisco Pro Display',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: context.adaptiveSize(100)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Starting time:",
                              style: context.adaptiveTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: BaseColors.text,
                                fontFamily: 'San Francisco Pro Display',
                              ),
                            ),
                            Text(
                              DateFormat(
                                'HH:mm',
                              ).format(_excursion.startingTime),
                              style: context.adaptiveTextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: BaseColors.accent,
                                fontFamily: 'San Francisco Pro Display',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: context.adaptiveSize(32)),
                    Row(
                      children: [
                        if (_currentPage1 > 0)
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: context.adaptiveSize(20),
                            ),
                            onPressed: _scrollLeft,
                          ),
                        Expanded(
                          child: SizedBox(
                            height: context.adaptiveSize(48),
                            child: ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: _excursion.iconServices.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    right: context.adaptiveSize(12),
                                  ),
                                  height: context.adaptiveSize(48),
                                  width: context.adaptiveSize(46),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color.fromARGB(255, 224, 224, 224),
                                      width: 1,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Color.fromARGB(0, 1, 1, 1),
                                    child: Icon(
                                      _excursion.iconServices[index],
                                      color: BaseColors.text,
                                      size: context.adaptiveSize(20),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        if (_currentPage1 < icons.length - 5)
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: context.adaptiveSize(14),
                              color: Color.fromARGB(255, 189, 189, 189),
                            ),
                            onPressed: _scrollRight,
                          ),
                      ],
                    ),
                    SizedBox(height: 40),
                    GreyLine(),
                    SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transfer:',
                          style: context.adaptiveTextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: BaseColors.text,
                            fontFamily: 'San Francisco Pro Display',
                          ),
                        ),
                        SizedBox(height: context.adaptiveSize(8.0)),
                        Text(
                          _excursion.transfer,
                          style: context.adaptiveTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 130, 130, 130),
                            fontFamily: 'San Francisco Pro Display',
                          ),
                        ),
                        SizedBox(height: context.adaptiveSize(32.0)),
                        Text(
                          'Sights:',
                          style: context.adaptiveTextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: BaseColors.text,
                            fontFamily: 'San Francisco Pro Display',
                          ),
                        ),
                        SizedBox(height: context.adaptiveSize(8.0)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            _excursion.sights.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(
                                bottom: context.adaptiveSize(8.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: BaseColors.accent,
                                    size: context.adaptiveSize(16),
                                  ),
                                  SizedBox(width: context.adaptiveSize(8.0)),
                                  Text(
                                    _excursion.sights[index],
                                    style: context.adaptiveTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 130, 130, 130),
                                      fontFamily: 'San Francisco Pro Display',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: context.adaptiveSize(32.0)),
                        Text(
                          'Not included:',
                          style: context.adaptiveTextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: BaseColors.text,
                            fontFamily: 'San Francisco Pro Display',
                          ),
                        ),
                        SizedBox(height: context.adaptiveSize(8.0)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            _excursion.notIncluded.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(
                                bottom: context.adaptiveSize(8.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.clear,
                                    color: BaseColors.text,
                                    size: context.adaptiveSize(16),
                                  ),
                                  SizedBox(width: context.adaptiveSize(8.0)),
                                  Text(
                                    _excursion.notIncluded[index],
                                    style: context.adaptiveTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 130, 130, 130),
                                      fontFamily: 'San Francisco Pro Display',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: context.adaptiveSize(32.0)),
                        Text(
                          'Take with you:',
                          style: context.adaptiveTextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: BaseColors.text,
                            fontFamily: 'San Francisco Pro Display',
                          ),
                        ),
                        SizedBox(height: context.adaptiveSize(8.0)),
                        Text(
                          _excursion.takeWithYou,
                          style: context.adaptiveTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 130, 130, 130),
                            fontFamily: 'San Francisco Pro Display',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.adaptiveSize(40)),
                    GreyLine(),
                    SizedBox(height: context.adaptiveSize(24)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _excursion.rating.toString(),
                              style: context.adaptiveTextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: BaseColors.accent,
                                fontFamily: 'San Francisco Pro Display',
                              ),
                            ),
                            SizedBox(width: context.adaptiveSize(6)),
                            StarRating(rating: _excursion.rating),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${_excursion.numberReviews} guest reviews",
                              style: context.adaptiveTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 130, 130, 130),
                                fontFamily: 'San Francisco Pro Display',
                              ),
                            ),
                            SizedBox(width: context.adaptiveSize(12)),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: context.adaptiveSize(14),
                              color: Color.fromARGB(255, 189, 189, 189),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: context.adaptiveSize(27)),
                    GreyLine(),
                    SizedBox(height: context.adaptiveSize(40)),

                    CustomTextFieldWithGradientButton(
                      text: "${_excursion.price.cleanFormat()} € / person",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'San Francisco Pro Display',
                        color: BaseColors.text,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SlideTransition(
        position: _bottomBarSlideAnimation,
        child: BottomBar(currentScreen: widget),
      ),
    );
  }
}

extension CleanDoubleFormat on double {
  String cleanFormat() {
    return toStringAsFixed(2).replaceAll('.00', '');
  }
}
