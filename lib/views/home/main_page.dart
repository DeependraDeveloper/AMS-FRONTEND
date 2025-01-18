import 'package:amsystm/views/attendence_employee/attendence.dart';
// import 'package:amsystm/views/home/clock.dart';
import 'package:amsystm/views/home/home_page.dart';
import 'package:amsystm/views/leave/leave.dart';
import 'package:amsystm/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int currIdx = 0;

//   List<Widget> pages = const <Widget>[
//     HomePage(),
//     AttedencePage(),
//     LeavePage(),
//     ProfilePage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final role = context.read<AuthBloc>().state.user.role ?? '';
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: pages[currIdx],
//       bottomNavigationBar: ClipRRect(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//         child: BottomNavigationBar(
//           currentIndex: currIdx,
//           onTap: (value) {
//             setState(() {
//               currIdx = value;
//             });
//           },
//           elevation: 1,
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.blue,
//           unselectedItemColor: Colors.black,
//           selectedItemColor: Colors.white,
//           iconSize: 30,
//           showSelectedLabels: true,
//           showUnselectedLabels: false,
//           selectedFontSize: 14,
//           items: <BottomNavigationBarItem>[
//             const BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'H O M E',
//             ),
//             BottomNavigationBarItem(
//               icon: const Icon(Icons.hourglass_empty_outlined),
//               label: role == 'employee'
//                   ? 'A T T E N D E N C E'
//                   : 'E M P L O Y E E S',
//             ),
//             const BottomNavigationBarItem(
//               icon: Icon(Icons.add_business_outlined),
//               label: 'L E A V E',
//             ),
//             const BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: 'P R O F I L E',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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

  List<IconData> icons = const <IconData>[
    Icons.home,
    Icons.hourglass_full,
    Icons.time_to_leave,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currIdx],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue,
        backgroundColor: Colors.white,
        height: 65,
        animationDuration: const Duration(milliseconds: 350),
        items: <Widget>[
          ...icons
              .map((e) => Icon(
                    e,
                    color: currIdx == icons.indexOf(e)
                        ? Colors.white
                        : Colors.black,
                    size: 34,
                  ))
              ,
        ],
        onTap: (index) {
          setState(() {
            currIdx = index;
          });
        },
      ),
    );
  }
}
