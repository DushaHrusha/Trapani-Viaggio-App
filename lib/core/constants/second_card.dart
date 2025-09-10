import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:test_task/data/models/card_data.dart';
import 'package:test_task/presentation/apartmens_detail_screen.dart';
import 'package:test_task/core/constants/custom_text_field_with_gradient_button.dart';

class SecondCard extends StatelessWidget {
  final CardData data;
  final BuildContext context;
  final TextStyle style;
  const SecondCard({
    super.key,
    required this.context,
    required this.style,
    required this.data,
  });

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
                      child: Image.asset(
                        data.imageUrl[0],
                        width: MediaQuery.maybeWidthOf(context),
                        fit: BoxFit.cover,
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
                            data.title,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          StarRating(rating: data.rating),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 23, right: 23),
                  child: Text(
                    data.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ),
                SizedBox(height: 21),
              ],
            ),
          ),
          SizedBox(height: 21),
          CustomTextFieldWithGradientButton(
            text: "${data.price} €",
            style: style,
          ),
        ],
      ),
    );
  }
}
