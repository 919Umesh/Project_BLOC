import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project_bloc/src/page_tabs/profile_screen.dart';

import 'chat_screen.dart';
import 'home_screen.dart';


class PageWrapper extends StatefulWidget {
  const PageWrapper({super.key});

  @override
  State<PageWrapper> createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  int _selectedIndex = 0;


  final List<Widget> _pages = [
    const HomeScreen(),
    const ProfileScreen(),
    const ChatScreen(),
  ];

  final List<String> _titles = [
    'Home',
    'Profile',
    'Chat',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
        backgroundColor: Colors.blue.shade50,
        color: Colors.blue,
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Bootstrap.house, size: 25, color: Colors.white),
          Icon(Bootstrap.chat_right, size: 25, color: Colors.white),
          Icon(Bootstrap.envelope, size: 25, color: Colors.white),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
