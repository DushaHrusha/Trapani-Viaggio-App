import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/cubits/bookmarks_cubit.dart';
import 'package:test_task/data/models/bookmark.dart';
import 'package:test_task/core/adaptive_size_extension.dart';
import 'package:test_task/data/models/card_data.dart';
import 'package:test_task/presentation/apartment_detail_screen.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/custom_text_field_with_gradient_button.dart';

class FirstCard extends StatefulWidget {
  final CardData data;

  final int index;
  final BuildContext context;
  final TextStyle style;
  const FirstCard({
    super.key,
    required this.data,
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
  late List<IconData> icons;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _data = widget.data;

    icons = _data.iconDataList;
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

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

  String _getFirstSentence(String text) {
    // Регулярное выражение для поиска первого предложения
    final sentenceRegex = RegExp(r'^(.*?[.!?])');
    final match = sentenceRegex.firstMatch(text);

    return match != null ? match.group(1)!.trim() : text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.adaptiveSize(44)),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(context.adaptiveSize(32)),
              ),
              border: Border.all(color: Color.fromARGB(255, 224, 224, 224)),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(context.adaptiveSize(32)),
                        topRight: Radius.circular(context.adaptiveSize(32)),
                      ),
                      child: SizedBox(
                        height: context.adaptiveSize(375),
                        width: MediaQuery.of(context).size.width,
                        child: PageView.builder(
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          itemCount: _data.imageUrl.length,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: _data.imageUrl[index],
                              placeholder:
                                  (context, url) => CircularProgressIndicator(),
                              errorWidget:
                                  (context, url, error) => Icon(Icons.error),
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      right: context.adaptiveSize(24),
                      top: context.adaptiveSize(24),
                      child: BlocBuilder<BookmarksCubit, List<Bookmark>>(
                        builder: (context, bookmarks) {
                          final isBookmarked = context
                              .read<BookmarksCubit>()
                              .isBookmarked(_data);
                          return GestureDetector(
                            onTap: () {
                              context.read<BookmarksCubit>().toggleBookmark(
                                _data,
                              );
                            },
                            child: Container(
                              height: context.adaptiveSize(56),
                              width: context.adaptiveSize(56),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(context.adaptiveSize(16)),
                                ),
                                shape: BoxShape.rectangle,
                                color: Color.fromARGB(87, 255, 255, 255),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(context.adaptiveSize(16)),
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
                      child: _buildIndicator(_data.imageUrl.length),
                    ),
                  ],
                ),
                SizedBox(height: context.adaptiveSize(12)),
                Padding(
                  padding: EdgeInsets.only(
                    left: context.adaptiveSize(23),
                    right: context.adaptiveSize(23),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              _data.title,
                              softWrap: true,
                              style: context.adaptiveTextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: BaseColors.text,
                              ),
                            ),
                            StarRating(rating: _data.rating),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.adaptiveSize(12)),
                Padding(
                  padding: EdgeInsets.only(
                    left: context.adaptiveSize(23),
                    right: context.adaptiveSize(23),
                  ),
                  child: Text(
                    _getFirstSentence(_data.description),
                    style: context.adaptiveTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: BaseColors.text,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),

                SizedBox(height: context.adaptiveSize(21)),
              ],
            ),
          ),
          SizedBox(height: context.adaptiveSize(24)),
          Row(
            children: [
              if (_currentPage1 > 0)
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: context.adaptiveSize(16),
                  ),
                  onPressed: _scrollLeft,
                ),
              Expanded(
                child: SizedBox(
                  height: context.adaptiveSize(48),
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: icons.length,
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
                            icons[index],
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
                    size: context.adaptiveSize(12),
                    color: Color.fromARGB(255, 189, 189, 189),
                  ),
                  onPressed: _scrollRight,
                ),
            ],
          ),
          SizedBox(height: context.adaptiveSize(24)),
          CustomTextFieldWithGradientButton(
            text: "${_data.price.toStringAsFixed(0)} €",
            style: widget.style,
          ),
        ],
      ),
    );
  }
}
