import 'package:flutter/material.dart';
import 'package:test_task/base_colors.dart';

class CustomBackgroundWithImage extends StatelessWidget {
  final Image image;
  final List<Widget> children;
  const CustomBackgroundWithImage({
    super.key,
    required this.image,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        image,
        Padding(
          padding: const EdgeInsets.only(top: 298),
          child: Container(
            decoration: BoxDecoration(
              color: BaseColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            constraints: BoxConstraints.expand(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 298,
            ),
            child: Column(
              children: children, // Используйте переданные виджеты
            ),
          ),
        ),
      ],
    );
  }
}
