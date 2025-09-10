import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_task/presentation/apartmens_detail_screen.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/bottom_bar.dart';
import 'package:test_task/core/constants/custom_app_bar.dart';
import 'package:test_task/core/constants/custom_background_with_gradient.dart';
import 'package:test_task/core/constants/custom_text_field_with_gradient_button.dart';
import 'package:test_task/presentation/dates_guests_screen.dart';
import 'package:test_task/data/models/excursion_model.dart';

class ExcursionDetailScreen extends StatefulWidget {
  final Excursion excursion;

  ExcursionDetailScreen({super.key, required this.excursion});

  @override
  State<ExcursionDetailScreen> createState() => _ExcursionDetailScreenState();
}

class _ExcursionDetailScreenState extends State<ExcursionDetailScreen> {
  final PageController _pageController = PageController();

  late int displayedIconsCount;

  int _currentPage = 0;

  final List<IconData> icons = [
    Icons.luggage,
    Icons.luggage,
    Icons.luggage,
    Icons.edit,
    Icons.wb_sunny,
    Icons.pets,
    Icons.smoke_free,
  ];

  bool showAllIcons = false;

  late final Excursion _excursion;

  final ScrollController _scrollController = ScrollController();

  final MapController _mapController = MapController();

  final LatLng _targetLocation = LatLng(55.0084, 82.9348);

  int _currentPage1 = 0;

  @override
  void initState() {
    super.initState();
    displayedIconsCount = showAllIcons ? icons.length : 5;
    _excursion = widget.excursion;
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
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
            CustomAppBar(label: "excursion info"),
            Divider(height: 0),
            SizedBox(height: 40),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 30),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                            child: SizedBox(
                              height: 180,
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
                            right: 16,
                            top: 16,
                            child: Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                shape: BoxShape.rectangle,
                                color: Color.fromARGB(87, 255, 255, 255),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 5.0,
                                    sigmaY: 5.0,
                                  ),
                                  child: Icon(
                                    Icons.bookmark_outline,
                                    color: Color.fromARGB(255, 251, 251, 253),
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: _buildIndicator(_excursion.imageUrl.length),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        _excursion.title,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          fontFamily: "SF Pro Display",
                          color: BaseColors.text,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        _excursion.description,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "SF Pro Display",
                          color: Color.fromARGB(255, 130, 130, 130),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    spacing: 100,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Duration:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "SF Pro Display",
                              color: BaseColors.text,
                            ),
                          ),
                          Text(
                            "${_excursion.duration} hours",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: "SF Pro Display",
                              color: BaseColors.accent,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Starting time:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "SF Pro Display",
                              color: BaseColors.text,
                            ),
                          ),
                          Text(
                            DateFormat('HH:mm').format(_excursion.startingTime),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: "SF Pro Display",
                              color: BaseColors.accent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      if (_currentPage1 > 0)
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: _scrollLeft,
                        ),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: _excursion.iconServices.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(right: 12),
                                height: 48,
                                width: 46,
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
                            size: 14,
                            color: Color.fromARGB(255, 189, 189, 189),
                          ),
                          onPressed: _scrollRight,
                        ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Divider(height: 0),
                  SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transfer:',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          fontFamily: "SF Pro Display",
                          color: BaseColors.text,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        _excursion.transfer,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "SF Pro Display",
                          color: Color.fromARGB(255, 130, 130, 130),
                        ),
                      ),
                      SizedBox(height: 32.0),
                      Text(
                        'Sights:',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          fontFamily: "SF Pro Display",
                          color: BaseColors.text,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Column(
                        children: List.generate(
                          _excursion.sights.length,
                          (index) => Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: BaseColors.accent,
                                size: 16,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                _excursion.sights[index],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "SF Pro Display",
                                  color: Color.fromARGB(255, 130, 130, 130),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 32.0),
                      Text(
                        'Not included:',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          fontFamily: "SF Pro Display",
                          color: BaseColors.text,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Column(
                        children: List.generate(
                          _excursion.notIncluded.length,
                          (index) => Row(
                            children: [
                              Icon(
                                Icons.clear,
                                color: BaseColors.text,
                                size: 16,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                _excursion.notIncluded[index],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "SF Pro Display",
                                  color: Color.fromARGB(255, 130, 130, 130),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 32.0),
                      Text(
                        'Take with you:',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          fontFamily: "SF Pro Display",
                          color: BaseColors.text,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        _excursion.takeWithYou,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "SF Pro Display",
                          color: Color.fromARGB(255, 130, 130, 130),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Divider(height: 0),
                  SizedBox(height: 24),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _excursion.rating.toString(),
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              fontFamily: "SF Pro Display",
                              color: BaseColors.accent,
                            ),
                          ),
                          SizedBox(width: 6),
                          StarRating(rating: _excursion.rating),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${_excursion.numberReviews} guest reviews",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "SF Pro Display",
                              color: Color.fromARGB(255, 130, 130, 130),
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Color.fromARGB(255, 189, 189, 189),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 27),
                  Divider(height: 0),
                  SizedBox(height: 40),
                  CustomTextFieldWithGradientButton(
                    text: "${_excursion.price.cleanFormat()} € / person",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: "SF Pro Display",
                      color: BaseColors.text,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(currentScreen: widget),
    );
  }
}

extension CleanDoubleFormat on double {
  String cleanFormat() {
    return toStringAsFixed(2).replaceAll('.00', '');
  }
}
