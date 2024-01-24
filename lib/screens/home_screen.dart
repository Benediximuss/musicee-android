import 'package:flutter/material.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/screens/tabs/explore_tab.dart';
import 'package:musicee_app/screens/tabs/profile_tab.dart';
import 'package:musicee_app/screens/tabs/people_tab.dart';
import 'package:musicee_app/services/auth/auth_manager.dart';
import 'package:musicee_app/utils/color_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  final List<String> _tabTitles = ['Explore', 'People', 'Profile'];
  RefreshHolder refreshHolder = RefreshHolder();

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
            //Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
            //Navigator.pushReplacementNamed(context, Routes.homeScreen);

            switch (_currentIndex) {
              case 0:
                refreshHolder.tab1Refresh!();
              case 1:
                refreshHolder.tab2Refresh!();
              case 2:
                refreshHolder.tab3Refresh!();
              default:
                return;
            }
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
              AuthManager.logout();
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
            icon: Icon(Icons.groups_2),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: const TextStyle(
          fontSize: 18,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return ExploreTab(parentRefreshHolder: refreshHolder);
      case 1:
        return PeopleTab(parentRefreshHolder: refreshHolder);
      case 2:
        return ProfileTab(parentRefreshHolder: refreshHolder);
      default:
        return Container();
    }
  }
}

class RefreshHolder {
  late void Function()? tab1Refresh;
  late void Function()? tab2Refresh;
  late void Function()? tab3Refresh;
}
