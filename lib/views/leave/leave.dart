import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/bloc/user/user_bloc.dart';
import 'package:amsystm/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LeavePage extends StatelessWidget {
  const LeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthBloc>().state.user;
    final String role = user.role ?? '';

    return Scaffold(
      floatingActionButton: role == 'company'
          ? null
          : FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.blue,
              onPressed: () {
                context.pushNamed('add-leave');
              },
              child: const Icon(Icons.add),
            ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state.error.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state.message.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (BuildContext context, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.black,
            child: state.leaves.isEmpty
                ? Center(
                    child: Text(
                      role == 'employee' ? 'No Leaves' : 'No Leave Requests',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: state.leaves.length,
                    itemBuilder: (BuildContext context, int index) {
                      final leave = state.leaves[index];
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(68, 121, 85, 72),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              leave.leaveType ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  leave.leaveFrom ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  leave.leaveTo ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  leave.leaveStatus ?? '',
                                  style: TextStyle(
                                    color: leave.leaveStatus == 'Approved'
                                        ? Colors.green
                                        : leave.leaveStatus == 'Rejected'
                                            ? Colors.red
                                            : Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              leave.leaveReason ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
