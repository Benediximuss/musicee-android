// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:musicee_app/screens/tabs/home_tab.dart';
import 'package:musicee_app/screens/tabs/profile_tab.dart';
import 'package:musicee_app/screens/tabs/search_tab.dart';
import 'package:musicee_app/theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  final List<String> _tabTitles = ['Explore', 'Search', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: AppColors.swatchPrimary,
      ),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            _tabTitles[_currentIndex],
            style: TextStyle(
              fontSize: 25,
              color: AppColors.colorPrimaryText,
              ),
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            _buildTabContent(0),
            _buildTabContent(1),
            _buildTabContent(2),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.swatchPrimary.shade50,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300), // Switching speed
                curve: Curves.easeInOut,
              );
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music_rounded),
              label: 'Library',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return HomeTab();
      case 1:
        return SearchTab();
      case 2:
        return ProfileTab();
      default:
        return Container(); // Handle other cases if needed
    }
  }
}
