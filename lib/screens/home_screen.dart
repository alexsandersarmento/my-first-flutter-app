import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/pages/home_page.dart';
import 'package:my_first_flutter_app/pages/products_page.dart';
import 'package:my_first_flutter_app/pages/profile_page.dart';
import 'package:my_first_flutter_app/components/HomeScreen/custom_navigation_destination.dart';
import 'package:my_first_flutter_app/components/HomeScreen/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0; 

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        drawer: const CustomDrawer(),
        body: IndexedStack(
          index: currentPageIndex,
          children: const <Widget>[
            HomePage(),
            ProductsPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          elevation: 1,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            CustomNavigationDestination(
              activeColor: Colors.white,
              color: Colors.grey,
              icon: const Icon(Icons.home_outlined),
              label: 'Home',
              selected: currentPageIndex == 0,
              onTap: () => {
                setState(() {
                  currentPageIndex = 0;
                })
              },
            ),
            CustomNavigationDestination(
              icon: const Icon(Icons.business_outlined),
              activeColor: Colors.white,
              color: Colors.grey,
              label: 'Products',
              selected: currentPageIndex == 1,
              onTap: () => {
                setState(() {
                  currentPageIndex = 1;
                })
              },
            ),
            CustomNavigationDestination(
              icon: const Icon(Icons.school_outlined),
              activeColor: Colors.white,
              color: Colors.grey,
              label: 'Profile',
              selected: currentPageIndex == 2,
              onTap: () => {
                setState(() {
                  currentPageIndex = 2;
                })
              },
            ),
          ],
        ),
      ),
    );
  }
}