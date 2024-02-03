import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthBloc>().state.user;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 56,
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReFuNVUscuscAPv7N7laen4v8CC5cb99ZDvi6d_N_-htu6NwOmNSBic_UuZWQAn2YsSP4&usqp=CAU'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  user.name ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Active since - ${user.createdAt?.toIso8601String().split('T').first ?? ''}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Personal Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '✏️ Edit',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(68, 121, 85, 72),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.phone,
                color: Colors.white,
              ),
              title: const Text(
                'Phone',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              trailing: Text(
                user.phone.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(68, 121, 85, 72),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.email,
                color: Colors.white,
              ),
              title: const Text(
                'Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              trailing: FittedBox(
                // Wrap trailing text in Expanded widget
                child: Text(
                  user.email ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  softWrap: true, // Allow text to wrap to the next line
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(68, 121, 85, 72),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.insert_invitation_rounded,
                color: Colors.white,
              ),
              title: const Text(
                'Company',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              trailing: FittedBox(
                // Wrap trailing text in Expanded widget
                child: Text(
                  user.organization.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  softWrap: true, // Allow text to wrap to the next line
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(68, 121, 85, 72),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.departure_board,
                color: Colors.white,
              ),
              title: const Text(
                'Deparment',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              trailing: Text(
                user.department.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(68, 121, 85, 72),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.design_services,
                color: Colors.white,
              ),
              title: const Text(
                'Designation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              trailing: Text(
                user.designation.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
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
                'LOGOUT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
