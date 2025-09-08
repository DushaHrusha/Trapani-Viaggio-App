import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:test_task/first_card.dart';

class SecondCard extends StatelessWidget {
  final dynamic excursion;
  final int rating;
  final int index;
  final BuildContext context;

  const SecondCard({
    super.key,
    required this.excursion,
    required this.rating,
    required this.index,
    required this.context,
  });

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
                      child: Image.asset(
                        excursion.imageUrl[0],
                        width: 380,
                        fit: BoxFit.cover,
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
                  ],
                ),
                SizedBox(height: 16),
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
                            excursion.title,
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
                              final isFilled = starIndex < rating;
                              return GestureDetector(
                                onTap: () {
                                  // Здесь нужно будет реализовать логику обновления рейтинга
                                  // Например, через колбэк или стейт-менеджмент
                                },
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
                    excursion.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ),
                SizedBox(height: 21),
              ],
            ),
          ),
          SizedBox(height: 21),

          CustomTextFieldWithGradientButton(text: "30"),
        ],
      ),
    );
  }
}
