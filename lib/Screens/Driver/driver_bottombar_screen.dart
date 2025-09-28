import 'package:flutter/material.dart';
import 'package:xpressfly_git/Common%20Components/common_bottombar.dart';
import 'package:xpressfly_git/Screens/Driver/driver_homescreen.dart';
import 'package:xpressfly_git/Screens/Driver/order_history_screen.dart';
import 'package:xpressfly_git/Screens/Driver/order_request_screen.dart';
import 'package:xpressfly_git/Screens/Driver/profile_screen.dart';

import '../../Common Components/common_drawer.dart';

class DriverBottomBarScreen extends StatefulWidget {
  const DriverBottomBarScreen({super.key});

  @override
  State<DriverBottomBarScreen> createState() => _DriverBottomBarScreenState();
}

class _DriverBottomBarScreenState extends State<DriverBottomBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DriverHomeScreen(),
    OrderRequestScreen(),
    const OrderHistoryScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CommonDrawer(),
      resizeToAvoidBottomInset: false,
      body: IndexedStack(index: _selectedIndex, children: _screens),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
