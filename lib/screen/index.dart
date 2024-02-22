import 'package:flutter/material.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/screen/cart_screen.dart';
import 'package:test_flutter_2/screen/home_screen.dart';
import 'package:test_flutter_2/screen/pet_service_screen.dart';
import 'package:test_flutter_2/screen/shopping_screen.dart';
import 'package:test_flutter_2/screen/user_screen.dart';

class IndexScreen extends StatefulWidget {
  final int currentIndex;
  const IndexScreen({super.key, this.currentIndex = 0});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentPageIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const ShoppingScreen(),
    const PetServiceScreen(),
    const UserScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _currentPageIndex = widget.currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.mainColor,
      body: _pages[_currentPageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppColors.primary,
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        indicatorColor: AppColors.mainColorFocus,
        selectedIndex: _currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.local_mall,
              color: Colors.white,
            ),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Icon(Icons.cruelty_free, color: Colors.white),
            label: 'Service',
          ),
          NavigationDestination(
            icon: Icon(Icons.person, color: Colors.white),
            label: 'User',
          ),
        ],
      ),
    ));
  }
}
