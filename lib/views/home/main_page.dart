import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/views/attendence/attendence.dart';
import 'package:amsystm/views/home/home_page.dart';
import 'package:amsystm/views/leave/leave.dart';
import 'package:amsystm/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final role = context.read<AuthBloc>().state.user.role ?? '';
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
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'H O M E',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.hourglass_empty_outlined),
              label: role == 'employee'
                  ? 'A T T E N D E N C E'
                  : 'E M P L O Y E E S',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.add_business_outlined),
              label: 'L E A V E',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'P R O F I L E',
            ),
          ],
        ),
      ),
    );
  }
}
