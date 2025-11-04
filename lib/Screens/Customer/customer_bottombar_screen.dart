import 'package:flutter/material.dart';
import 'package:xpressfly_git/Common%20Components/common_bottombar.dart';
import 'package:xpressfly_git/Screens/Customer/customer_history_screen.dart';
import 'package:xpressfly_git/Screens/Customer/customer_homescreen.dart';
import 'package:xpressfly_git/Screens/Driver/order_history_screen.dart';
import 'package:xpressfly_git/Screens/Driver/profile_screen.dart';
import '../../Common Components/common_drawer.dart';

class CustomerBottomBarScreen extends StatefulWidget {
  const CustomerBottomBarScreen({super.key});

  @override
  State<CustomerBottomBarScreen> createState() =>
      _CustomerBottomBarScreenState();
}

class _CustomerBottomBarScreenState extends State<CustomerBottomBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const CustomerHomeScreen(),
    CustomerHistoryScreen(),
    const OrderHistoryScreen(),
    ProfileScreen(),
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
