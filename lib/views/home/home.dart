import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/views/attendence/attendence.dart';
import 'package:amsystm/views/home/clock.dart';
import 'package:amsystm/views/leave/leave.dart';
import 'package:amsystm/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currIdx = 0;

  List<Widget> pages = const <Widget>[
    AttedencePage(),
    LeavePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final String name = context.read<AuthBloc>().state.user.name ?? '';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Hi $name!',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Clock(),
          ),
        ],
      ),
      body: pages[currIdx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currIdx,
        onTap: (value) {
          setState(() {
            currIdx = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.blue,
        iconSize: 30,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.hourglass_empty_outlined),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business_outlined),
            label: 'Leave',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
