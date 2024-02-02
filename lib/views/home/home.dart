import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/views/home/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String name = context.read<AuthBloc>().state.user.name ?? '';
    return Scaffold(
        backgroundColor: Colors.blue,
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
          actions: [
            const Clock(),
            const SizedBox(
              width: 20,
            ),
            // logout button
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      const SignOutEvent(),
                    );
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: const Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Welcome to the Home Page',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'You are now logged in!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ));
  }
}
