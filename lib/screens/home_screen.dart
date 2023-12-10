import 'package:flutter/material.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/screens/tabs/home_tab.dart';
import 'package:musicee_app/screens/tabs/profile_tab.dart';
import 'package:musicee_app/screens/tabs/search_tab.dart';
import 'package:musicee_app/utils/color_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  final List<String> _tabTitles = ['Explore', 'Search', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          _tabTitles[_currentIndex],
        ),
        leading: TextButton(
          onPressed: () {
            print("3131: REFRESH");
            Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
          },
          child: const Icon(
            Icons.refresh,
            color: ColorManager.colorAppBarText,
            size: 30,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, Routes.welcomeScreen);
            },
            child: const Icon(
              Icons.logout,
              color: ColorManager.colorAppBarText,
              size: 30,
            ),
          ),
        ],
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
        backgroundColor: ColorManager.swatchPrimary.shade50,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300), // Switching speed
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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return const HomeTab();
      case 1:
        return const SearchTab();
      case 2:
        return const ProfileTab();
      default:
        return Container();
    }
  }
}
