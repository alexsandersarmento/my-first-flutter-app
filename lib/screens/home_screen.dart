import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/pages/home_page.dart';
import 'package:my_first_flutter_app/pages/products_page.dart';
import 'package:my_first_flutter_app/pages/profile_page.dart';

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
    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex,
        children: const <Widget>[
          HomePage(),
          ProductsPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black87,
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
            label: const Text('Home'),
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
            label: const Text('Products'),
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
            label: const Text('Profile'),
            selected: currentPageIndex == 2,
            onTap: () => {
              setState(() {
                currentPageIndex = 2;
              })
            },
          ),
        ],
      ),
    );
  }
}

class CustomNavigationDestination extends StatefulWidget {
  final Widget icon;
  final Widget label;
  final Color color;
  final Color activeColor;
  final bool selected;
  final double size;
  final VoidCallback onTap;

  const CustomNavigationDestination({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.activeColor,
    required this.selected,
    required this.onTap,
    this.size = 56
  }) : super(key: key);

  @override
  State<CustomNavigationDestination> createState() => _CustomNavigationDestinationState();
}

class _CustomNavigationDestinationState extends State<CustomNavigationDestination> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTheme.merge(
              data: IconThemeData(
                color: widget.selected ? widget.activeColor : widget.color,
              ),
              child: widget.icon,
            ),
            DefaultTextStyle.merge(
              style: TextStyle(
                color: widget.selected ? widget.activeColor : widget.color,
              ),
              child: widget.label,
            ),
          ],
        ),
      ),
    );
  }
}
