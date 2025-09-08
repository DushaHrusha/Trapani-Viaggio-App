import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/base_colors.dart';
import 'package:test_task/excursion.dart';
import 'package:test_task/sign_up_screen.dart';

class FirstCard extends StatefulWidget {
  final dynamic excursion;
  final int rating;
  final int index;
  final BuildContext context;
  const FirstCard({
    super.key,
    required this.excursion,
    required this.rating,
    required this.index,
    required this.context,
  });

  @override
  State<FirstCard> createState() => _FirstCardState();
}

class _FirstCardState extends State<FirstCard> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
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
            color: _currentPage == index ? Colors.blue : Colors.grey,
          ),
        );
      }),
    );
  }

  List<Excursion> _getExcursions() {
    return [
      Excursion(
        title: 'Горы Кaвказа',
        imageUrl: [
          "assets/file/maraslua.jpg",
          "assets/file/maraslua.jpg",
          "assets/file/maraslua.jpg",
          "assets/file/maraslua.jpg",
          "assets/file/maraslua.jpg",
        ],
        description:
            'Most popular bicycle tour to Natural Reserve Salt pans in Trapani.',
        price: 3500,
      ),
      // Добавьте другие экскурсии с изображениями...
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 44),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
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
                        child: PageView.builder(
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          itemCount: _getExcursions()[0].imageUrl.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              _getExcursions()[0].imageUrl[index],
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
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          shape: BoxShape.rectangle,
                          color: Color.fromARGB(
                            87,
                            255,
                            255,
                            255,
                          ), // Полупрозрачный цвет
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5.0,
                              sigmaY: 5.0,
                            ), // Эффект размытия
                            child: Icon(
                              Icons
                                  .bookmark_outline, // Используйте иконку закладки
                              color: Colors.white, // Оранжевый цвет для иконки
                              size: 35, // Размер иконки
                            ),
                          ),
                        ),
                      ),

                      // Иконка закладки
                    ),
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: _buildIndicator(
                        _getExcursions()[0].imageUrl.length,
                      ),
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
                            widget.excursion.title,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (starIndex) {
                              final isFilled = starIndex < widget.rating;
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Icon(
                                    isFilled
                                        ? Icons.star
                                        : Icons.star_border_outlined,
                                    color:
                                        isFilled
                                            ? Colors.orange
                                            : Colors.orange.withOpacity(0.5),
                                    size: 16,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 23, right: 23),
                  child: Text(
                    widget.excursion.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ),
                SizedBox(height: 21),
              ],
            ),
          ),
          SizedBox(height: 24),
          SizedBox(
            height: 80,
            child: ListView(
              controller: ScrollController(),
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 30),
              children: [
                _buildCharacteristicCircle(),
                SizedBox(width: 24),
                _buildCharacteristicCircle(),
                _buildCharacteristicCircle(),
                _buildCharacteristicCircle(),
                _buildCharacteristicCircle(),
                _buildCharacteristicCircle(),
              ],
            ),
          ),
          SizedBox(height: 24),
          CustomTextFieldWithGradientButton(text: "30 €"),
        ],
      ),
    );
  }

  Widget _buildCharacteristicCircle() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 235, 241, 244),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        "assets/file/menu.svg",
        color: Color.fromARGB(255, 85, 97, 178),
      ),
    );
  }
}

class CustomTextFieldWithGradientButton extends StatelessWidget {
  late String _text;
  CustomTextFieldWithGradientButton({super.key, required String text}) {
    _text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(0, 177, 11, 11),
        border: Border.all(
          color: const Color.fromARGB(255, 224, 224, 224),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 47),
            child: Text(
              _text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: "SF Pro Display",
                color: BaseColors.accent,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
            child: Container(
              height: 56,
              width: 190,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 127, 80),
                    Color.fromARGB(255, 85, 97, 178),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(
                      127,
                      255,
                      175,
                      175,
                    ), // Начальный цвет градиента
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: Offset(-5, -5),
                  ),
                  BoxShadow(
                    color: Color.fromARGB(
                      127,
                      132,
                      147,
                      197,
                    ), // Конечный цвет градиента
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Book now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "SF Pro Display",
                        ),
                      ),
                    ),
                  ),

                  Container(
                    height: 56,
                    width: 1,
                    color: const Color.fromARGB(255, 138, 120, 178),
                  ),

                  SizedBox(
                    width: 60,
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
