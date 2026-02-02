import 'package:flutter/material.dart';
import 'package:todo_list/home_screen2.dart';
import 'package:todo_list/stats_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [const HomeScreen2(), const StatsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF6BBF8C),
          unselectedItemColor: Colors.grey.shade300,
          selectedIconTheme: const IconThemeData(
            color: Color(0xFF6BBF8C),
            size: 28,
          ),
          unselectedIconTheme: const IconThemeData(
            color: Colors.grey,
            size: 24,
          ),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Color(0xFF6BBF8C),
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Tasks'),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Stats',
            ),
          ],
        ),
      ),
    );
  }
}
