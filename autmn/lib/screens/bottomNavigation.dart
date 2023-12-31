import 'package:autmn/screens/homescreen.dart';
import 'package:autmn/screens/news.dart';
import 'package:autmn/screens/pendingScreen.dart';
import 'package:autmn/screens/profile.dart';
import 'package:autmn/screens/schedule.dart';
import 'package:autmn/screens/userController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationBarScreen extends StatefulWidget {

    final String fname;
  final String lname;
final String email;
  final String facility;
  final String role;
  String position;
  final String employeeKey;
  final String playerID;

  NavigationBarScreen({
    required this.fname,
    required this.lname,
    required this.email,
    required this.facility,
    required this.role,
    required this.position,
    required this.employeeKey,
    required this.playerID,
  });

  
  
  @override
  // String? fname;
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {

 UserContoller userContoller = Get.put(UserContoller()); 

  int _selectedIndex = 0;

 final List<Widget> _widgetOptions = [
    NextScreen(),
    MyShiftsScreen(),
    ScheduledScreen(),
    NewsScreen(),
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
   
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
         type: BottomNavigationBarType.fixed, // Add this line
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending),
            label: 'Pending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}