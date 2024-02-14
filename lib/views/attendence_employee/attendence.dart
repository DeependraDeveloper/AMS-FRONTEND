import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AttedencePage extends StatelessWidget {
  const AttedencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String role = context.read<AuthBloc>().state.user.role ?? '';
    final String id = context.read<AuthBloc>().state.user.id ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          role == 'employee' ? 'Attendences' : 'Employees',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: role == 'employee'
            ? null
            : [
                IconButton(
                  onPressed: () {
                    context.pushNamed('edit-attendence');
                  },
                  icon: const Icon(
                    Icons.model_training_rounded,
                    color: Colors.black,
                  ),
                ),
              ],
      ),
      floatingActionButton: role == 'employee'
          ? null
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'add-employee',
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
                const SizedBox(width: 10),
                FloatingActionButton(
                  heroTag: 'download-attendence present month',
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    context.read<UserBloc>().add(
                          DownloadAttendanceEvent(
                            id: id,
                          ),
                        );
                  },
                  child: const Icon(
                    Icons.download,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Column(
          children: [
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
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text(state.message),
                        //     backgroundColor: Colors.green,
                        //   ),
                        // );
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
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.attendences.length,
                                itemBuilder: (context, index) {
                                  final attendence = state.attendences[index];
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[200],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              attendence.createdAt
                                                      ?.toIso8601String()
                                                      .split('T')
                                                      .first ??
                                                  'N/A',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              attendence.status
                                                      ?.toUpperCase() ??
                                                  'N/A',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: attendence.status ==
                                                        'present'
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "⏳ ${attendence.inTime ?? 'N/A'}",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "⌛ ${attendence.outTime ?? 'N/A'}",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
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
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text(state.message),
                        //     backgroundColor: Colors.green,
                        //   ),
                        // );
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
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.users.length,
                                itemBuilder: (context, index) {
                                  final user = state.users[index];
                                  return GestureDetector(
                                    onTap: () {
                                      context.pushNamed('employee-detail',
                                          extra: user);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[200],
                                      ),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "👦 ${user.name ?? 'N/A'}",
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "🎓 ${user.department.toString()}",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 180),
                                                  Text(
                                                    "🏠 ${user.createdAt?.toIso8601String().split('T').first}",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                "💼 ${user.designation.toString()}",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
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
          ],
        ),
      ),
    );
  }
}
