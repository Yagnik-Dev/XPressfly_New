import 'package:flutter/material.dart';
import 'package:xpressfly_git/Common%20Components/common_bottombar.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Screens/Driver/driver_homescreen.dart';

class DriverBottomBarScreen extends StatefulWidget {
  const DriverBottomBarScreen({super.key});

  @override
  State<DriverBottomBarScreen> createState() => _DriverBottomBarScreenState();
}

class _DriverBottomBarScreenState extends State<DriverBottomBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DriverHomeScreen(),
    const Screen2(),
    const Screen3(),
    const Screen4(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(index: _selectedIndex, children: _screens),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
      // bottomNavigationBar: CustomBottomBar(
      //   selectedIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}

/// Example other screens
class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Screen 2"));
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Screen 3"));
  }
}

class Screen4 extends StatelessWidget {
  const Screen4({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Screen 4"));
  }
}
