import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget {
  final String label;
  const CustomAppBar({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25.0, right: 20, left: 20, bottom: 23),
      child: SizedBox(
        height: 27,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset('assets/file/left.svg', height: 24),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(minWidth: 24, maxHeight: 24),
              onPressed: () => Navigator.pop(context),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Berlin Sans FB',
                  height: 1.0,
                  color: Color.fromARGB(255, 109, 109, 109),
                ),
              ),
            ),
            IconButton(
              icon: SvgPicture.asset('assets/file/menu.svg', height: 24),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(minWidth: 24, maxHeight: 24),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
