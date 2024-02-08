import 'package:amsystm/views/attendence/attendence.dart';
import 'package:amsystm/views/home/home_page.dart';
import 'package:amsystm/views/leave/leave.dart';
import 'package:amsystm/views/profile/profile.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currIdx = 0;

  List<Widget> pages = const <Widget>[
    HomePage(),
    AttedencePage(),
    LeavePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currIdx],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          currentIndex: currIdx,
          onTap: (value) {
            setState(() {
              currIdx = value;
            });
          },
          elevation: 1,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.white,
          iconSize: 30,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedFontSize: 14,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'H O M E',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hourglass_empty_outlined),
              label: 'A T T E N D E N C',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_business_outlined),
              label: 'L E A V E',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'P R O F I L E',
            ),
          ],
        ),
      ),
    );
  }
}
