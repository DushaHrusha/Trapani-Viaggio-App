import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/core/constants/base_colors.dart';
import 'package:test_task/core/constants/bottom_bar.dart';
import 'package:test_task/core/constants/custom_app_bar.dart';
import 'package:test_task/core/constants/custom_background_with_gradient.dart';
import 'package:test_task/core/constants/grey_line.dart';
import 'package:test_task/core/constants/second_card.dart';
import 'package:test_task/data/models/card_data.dart';
import 'package:provider/provider.dart';
import 'package:test_task/presentation/main_menu_screen.dart';

class BookmarksPage extends StatefulWidget {
  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _appBarAnimation;
  late Animation<double> _greyLineAnimation;
  late Animation<double> _textAnimation;
  late Animation<Offset> _bottomBarSlideAnimation;
  late Animation<double> _cardsOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    );

    _appBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.4, curve: Curves.easeInOut),
      ),
    );
    _greyLineAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.4, 0.5, curve: Curves.easeOut),
      ),
    );
    _textAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 0.6, curve: Curves.easeOut),
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
        curve: Interval(0.6, 0.8, curve: Curves.easeOutQuad),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.background,
      body: Consumer<BookmarksProvider>(
        builder: (context, bookmarksProvider, child) {
          if (bookmarksProvider.bookmarks.isEmpty) {
            return CustomBackgroundWithGradient(
              child: Column(
                children: [
                  FadeTransition(
                    opacity: _appBarAnimation,
                    child: CustomAppBar(
                      label: "bookmarks",
                      returnPage: MainMenuScreen(),
                    ),
                  ),
                  FadeTransition(
                    opacity: _greyLineAnimation,
                    child: GreyLine(),
                  ),
                  FadeTransition(
                    opacity: _textAnimation,
                    child: Container(
                      margin: EdgeInsets.only(top: 40),
                      alignment: Alignment.center,
                      child: Text(
                        'You have no bookmarks yet',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: BaseColors.text,
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return CustomBackgroundWithGradient(
            child: Column(
              children: [
                CustomAppBar(label: "bookmarks"),
                GreyLine(),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    itemCount: bookmarksProvider.bookmarks.length,
                    itemBuilder: (context, index) {
                      final bookmark = bookmarksProvider.bookmarks[index];
                      return FadeTransition(
                        opacity: _cardsOpacityAnimation,
                        child: SecondCard(
                          data: bookmark.cardData,
                          index: index,
                          context: context,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: BaseColors.accent,
                            fontSize: 21,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SlideTransition(
        position: _bottomBarSlideAnimation,
        child: BottomBar(currentScreen: context.widget),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SlideTransition(
        position: _bottomBarSlideAnimation,
        child: Container(
          margin: EdgeInsets.only(bottom: 30),
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1),
          ),
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: SvgPicture.asset(
                  "assets/file/sliders.svg",
                  color: BaseColors.accent,
                  height: 24,
                ),
                onPressed: () => {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BookmarksProvider extends ChangeNotifier {
  final List<Bookmark> _bookmarks = [];

  List<Bookmark> get bookmarks => _bookmarks;

  void toggleBookmark(CardData cardData) {
    Bookmark? existingBookmark;
    try {
      existingBookmark = _bookmarks.firstWhere(
        (bookmark) => bookmark.cardData.id == cardData.id,
      );
    } catch (e) {
      existingBookmark = null;
    }

    if (existingBookmark != null) {
      _bookmarks.remove(existingBookmark);
    } else {
      _bookmarks.add(Bookmark(cardData: cardData));
    }

    notifyListeners();
  }

  bool isBookmarked(CardData cardData) {
    return _bookmarks.any((bookmark) => bookmark.cardData.id == cardData.id);
  }
}

class Bookmark {
  final CardData cardData;

  Bookmark({required this.cardData});
}
