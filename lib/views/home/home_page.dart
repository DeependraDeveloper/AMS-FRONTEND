import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/views/home/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final String name = context.read<AuthBloc>().state.user.name ?? '';
    // final String profilePic =
    //     context.read<AuthBloc>().state.user.profilePic ?? '';

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReFuNVUscuscAPv7N7laen4v8CC5cb99ZDvi6d_N_-htu6NwOmNSBic_UuZWQAn2YsSP4&usqp=CAU',
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Hi $name!',
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        smallText(text: 'Total Attendence'),
                        const SizedBox(
                          width: 10,
                        ),
                        smallBox(color: Colors.green, text: '10'),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        smallText(text: 'Total Absence'),
                        const SizedBox(
                          width: 10,
                        ),
                        smallBox(color: Colors.red, text: '1'),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        smallText(text: 'Total Leaves'),
                        const SizedBox(
                          width: 10,
                        ),
                        smallBox(color: Colors.purple, text: '10'),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        smallText(text: 'Total Vocations'),
                        const SizedBox(
                          width: 10,
                        ),
                        smallBox(color: Colors.deepOrange, text: '1'),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              width: 165,
              height: 165,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Clock(),
            ),
            const SizedBox(
              height: 10,
            ),
            SvgPicture.asset(
              'assets/svgs/welcom.svg',
              width: 90,
              height: 90,
            ),
          ],
        ),
      ),
    );
  }
}

Widget smallText({required String text, FontWeight? weight}) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: weight ?? FontWeight.w500,
    ),
  );
}

Widget smallBox({
  required Color color,
  required String text,
}) {
  return Container(
    width: 35,
    height: 35,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}
