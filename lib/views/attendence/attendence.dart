import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AttedencePage extends StatelessWidget {
  const AttedencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String role = context.read<AuthBloc>().state.user.role ?? '';
    return Scaffold(
      floatingActionButton: role == 'employee'
          ? null
          : FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.blue,
              onPressed: () {
                context.pushNamed('add-employee');
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.black,
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/svgs/welcom.svg',
              width: 200,
              height: 200,
            ),
            role == 'employee'
                ? BlocConsumer<UserBloc, UserState>(
                    listener: (context, state) {
                      if (state.error.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      if (state.message.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const CircularProgressIndicator();
                      }
                      if (state.attendences.isEmpty) {
                        return const Text(
                          'No attendence found',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Attendences: ${state.attendences.length}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.attendences.length,
                                itemBuilder: (context, index) {
                                  final attendence = state.attendences[index];
                                  return Card(
                                    color: Colors.white,
                                    child: ListTile(
                                      trailing: Text(attendence.createdAt
                                              ?.toIso8601String()
                                              .split('T')
                                              .first ??
                                          'N/A'),
                                      title: Text(attendence.inTime ?? 'N/A'),
                                      subtitle:
                                          Text(attendence.outTime ?? 'N/A'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : BlocConsumer<UserBloc, UserState>(
                    listener: (context, state) {
                      if (state.error.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      if (state.message.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const CircularProgressIndicator();
                      }
                      if (state.users.isEmpty) {
                        return const Text(
                          'No Employees Added Yet!.',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Employees: ${state.users.length}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.users.length,
                                itemBuilder: (context, index) {
                                  final user = state.users[index];
                                  return Card(
                                    color: Colors.white,
                                    child: ListTile(
                                      trailing: Text(user.createdAt
                                              ?.toIso8601String()
                                              .split('T')
                                              .first ??
                                          'N/A'),
                                      title: Text(user.name ?? 'N/A'),
                                      subtitle: Text(
                                        user.phone.toString(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )

            // for admin show all employess and their attendence
          ],
        ),
      ),
    );
  }
}
