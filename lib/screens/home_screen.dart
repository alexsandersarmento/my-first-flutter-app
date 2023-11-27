import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/pages/home_page.dart';
import 'package:my_first_flutter_app/pages/products_page.dart';
import 'package:my_first_flutter_app/pages/profile_page.dart';
import 'package:my_first_flutter_app/components/HomeScreen/custom_navigation_destination.dart';
import 'package:my_first_flutter_app/components/HomeScreen/drawer.dart';
import 'package:material_symbols_icons/symbols.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int currentPageIndex = 0;
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 4,
      initialIndex: currentPageIndex,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        extendBody: true,
        drawer: const CustomDrawer(),
        body: IndexedStack(
          index: currentPageIndex,
          children: const <Widget>[
            HomePage(),
            ProductsPage(),
            ProfilePage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: TabBar(
            indicator: const BoxDecoration(
              color: Colors.transparent,
            ),
            onTap: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            tabs: const [
              Tab(
                child: CustomNavigationDestination(
                  icon: Icon(Icons.sports_kabaddi, color: Colors.black),
                  label: 'Evolução',
                  activeColor: Colors.blue,
                  color: Colors.black,
                ),
              ),
              Tab(
                child: CustomNavigationDestination(
                  icon: Icon(Symbols.calendar_add_on, color: Colors.black),
                  label: 'Agendar',
                  activeColor: Colors.blue,
                  color: Colors.black,
                ),
              ),
              Tab(
                child: CustomNavigationDestination(
                  icon: Icon(Icons.attach_money, color: Colors.black),
                  label: 'Débitos',
                  activeColor: Colors.blue,
                  color: Colors.black,
                ),
              ),
              Tab(
                child: CustomNavigationDestination(
                  icon: Icon(Icons.person_outline, color: Colors.black),
                  label: 'Perfil',
                  activeColor: Colors.blue,
                  color: Colors.black,
                ),
              ),
            ],
            controller: _tabController,
          ),
        )
      ),
    );
  }
}
