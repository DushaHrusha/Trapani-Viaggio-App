import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:test_task/data/models/card_data.dart';
import 'package:test_task/presentation/apartmens_detail_screen.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/custom_text_field_with_gradient_button.dart';

class FirstCard extends StatefulWidget {
  final CardData data;
  final int rating;
  final int index;
  final BuildContext context;
  final TextStyle style;
  const FirstCard({
    super.key,
    required this.data,
    required this.rating,
    required this.index,
    required this.context,
    required this.style,
  });

  @override
  createState() => _FirstCardState();
}

class _FirstCardState extends State<FirstCard> {
  final PageController _pageController = PageController();
  late CardData _data;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _data = widget.data;
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  final List<IconData> icons = [
    Icons.wifi,
    Icons.map,
    Icons.luggage,
    Icons.edit,
    Icons.wb_sunny,
    Icons.pets,
    Icons.smoke_free,
  ];
  bool showAllIcons = false;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  int _currentPage1 = 0;

  // Метод прокрутки вправо
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

  // Метод прокрутки влево
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 44),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              border: Border.all(color: Color.fromARGB(255, 224, 224, 224)),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      child: SizedBox(
                        height: 375,
                        width: MediaQuery.maybeWidthOf(context),
                        child: PageView.builder(
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          itemCount: _data.imageUrl.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              _data.imageUrl[index],
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      right: 24,
                      top: 24,
                      child: Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          shape: BoxShape.rectangle,
                          color: Color.fromARGB(87, 255, 255, 255),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
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
                      child: _buildIndicator(_data.imageUrl.length),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 23, right: 23),
                  child: Row(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Text(
                            _data.title,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              fontFamily: "SF Pro Display",
                              color: BaseColors.text,
                            ),
                          ),
                          StarRating(rating: 8.6),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 23, right: 23),
                  child: Text(
                    _data.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ),
                SizedBox(height: 21),
              ],
            ),
          ),
          SizedBox(height: 24),
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
                    itemCount: icons.length,
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
                          child: Icon(icons[index], color: BaseColors.text),
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
                    size: 12,
                    color: Color.fromARGB(255, 189, 189, 189),
                  ),
                  onPressed: _scrollRight,
                ),
            ],
          ),
          SizedBox(height: 24),
          CustomTextFieldWithGradientButton(
            text: "${_data.price} €",
            style: widget.style,
          ),
        ],
      ),
    );
  }
}
