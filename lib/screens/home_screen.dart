import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../helpers/app_theme.dart';
import '../helpers/navigation_theme.dart';
import '../widgets/custom_bottom_navigation.dart';
import './headlines_screen.dart';
import './news_feed_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController? _pageController;

  late NavigationTheme navigationTheme;
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    navigationTheme = NavigationTheme.getNavigationTheme();
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: const <Widget>[
            HeadlinesScreen(),
            NewsFeedScreen(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        animationDuration: const Duration(milliseconds: 350),
        selectedItemOverlayColor: navigationTheme.selectedOverlayColor,
        backgroundColor: navigationTheme.backgroundColor,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController!.jumpToPage(index);
        },
        items: <CustomBottomNavigationBarItem>[
          CustomBottomNavigationBarItem(
              title: "Home",
              icon: const Icon(LucideIcons.home, size: 20),
              activeIcon: const Icon(LucideIcons.home, size: 20),
              activeColor: navigationTheme.selectedItemColor,
              inactiveColor: navigationTheme.unselectedItemColor),
          CustomBottomNavigationBarItem(
              title: "My Feed",
              icon: const Icon(LucideIcons.bookmark, size: 20),
              activeIcon: const Icon(LucideIcons.bookmark, size: 20),
              activeColor: navigationTheme.selectedItemColor,
              inactiveColor: navigationTheme.unselectedItemColor),
        ],
      ),
    );
  }

  onTapped(value) {
    setState(() {
      _currentIndex = value;
    });
  }
}