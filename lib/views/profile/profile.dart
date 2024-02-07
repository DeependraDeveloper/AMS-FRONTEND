import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/data/models/user.dart';
import 'package:amsystm/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthBloc>().state.user;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReFuNVUscuscAPv7N7laen4v8CC5cb99ZDvi6d_N_-htu6NwOmNSBic_UuZWQAn2YsSP4&usqp=CAU'),
              ),
              const SizedBox(
                height: 10,
              ),
              smallText(text: user.name ?? '', weight: FontWeight.bold),
              smallText(
                text: user.email ?? '',
              ),
              const SizedBox(
                height: 8,
              ),
              smallText(
                text:
                    'Active since | ${user.createdAt?.toIso8601String().split('T').first ?? ''}',
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.black,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Personal Information',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: Column(
                  children: [
                    largeBox(
                      title: 'P H O NE',
                      icon: Icons.phone,
                      ans: user.phone.toString(),
                    ),
                    largeBox(
                      title: "E M A I L",
                      icon: Icons.email,
                      ans: user.email ?? '',
                    ),
                    largeBox(
                      title: "C O M P A N Y",
                      icon: Icons.factory,
                      ans: user.organization.toString(),
                    ),
                    largeBox(
                      title: "D E P A R T M E N T",
                      icon: Icons.category,
                      ans: user.department.toString(),
                    ),
                    largeBox(
                      title: "D E S I G N A T I O N",
                      icon: Icons.work,
                      ans: user.designation.toString(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Logout'),
                              content: const Text(
                                'Are you sure you want to logout?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.read<AuthBloc>().add(
                                          const SignOutEvent(),
                                        );
                                  },
                                  child: const Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text(
                          'L O G O U T',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget largeBox(
    {required String title, required IconData icon, required String ans}) {
  return Container(
    margin: const EdgeInsets.only(top: 6),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 47, 127, 192),
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      leading: Icon(
        icon,
        color: Colors.orange,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.fade,
        ),
      ),
      trailing: Text(
        ans,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
  );
}
