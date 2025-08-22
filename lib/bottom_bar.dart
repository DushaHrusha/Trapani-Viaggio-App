import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      currentIndex: _selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      iconSize: 24,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      items: [
        _buildNavItem('assets/file/home.svg'),
        _buildNavItem('assets/file/map.svg'),
        _buildNavItem('assets/file/bookmark.svg'),
        _buildNavItem('assets/file/user.svg'),
      ],
      onTap: _onItemTapped,
    );
  }

  BottomNavigationBarItem _buildNavItem(String icon) {
    return BottomNavigationBarItem(icon: SvgPicture.asset(icon), label: '');
  }
}
