// ignore_for_file: prefer_final_fields

import 'package:amsystm/bloc/user/user_bloc.dart';
import 'package:amsystm/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeDetailPage extends StatefulWidget {
  const EmployeeDetailPage({super.key, required this.user});

  final User user;

  @override
  State<EmployeeDetailPage> createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage> {
  static Map<int, String> monthsInYear = {
    1: "Jan",
    2: "Feb",
    3: "Mar",
    4: "Apr",
    5: "May",
    6: "Jun",
    7: "Jul",
    8: "Aug",
    9: "Sep",
    10: "Oct",
    11: "Nov",
    12: "Dec"
  };

  bool isExpanded = false;
  int _selectedIndex = 0;

  final TextEditingController _inTimeController = TextEditingController();
  final TextEditingController _outTimeController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(
          GetAttendencesOfParticularUserEvent(id: widget.user.id ?? ''),
        );
  }

  @override
  void dispose() {
    _inTimeController.dispose();
    _outTimeController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          widget.user.name ?? '',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          GestureDetector(
            onTap: () async {
              final url = 'mailto:${widget.user.email}';
              if (await launchUrl(Uri.tryParse(url)!)) {
                await launchUrl(Uri.tryParse(url)!);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 25),
              child: Icon(
                Icons.mail,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              final call = Uri.parse('tel:+91 ${widget.user.phone}');
              if (await canLaunchUrl(call)) {
                launchUrl(call);
              } else {
                throw 'Could not launch $call';
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.call,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: BlocConsumer<UserBloc, UserState>(
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!state.isLoading && state.allAttendences.isEmpty == true) {
              return const Center(
                child: Text(
                  'No Attendence Found',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.allAttendences.length,
                    itemBuilder: (context, index) {
                      var attendence = state.allAttendences[index];
                      return ExpansionTile(
                        collapsedIconColor:
                            isExpanded && _selectedIndex == index
                                ? Colors.blue
                                : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.grey[200],
                        iconColor: Colors.black,
                        initiallyExpanded: false,
                        onExpansionChanged: (value) =>
                            setState(() => isExpanded = value),
                        trailing: Icon(
                          (isExpanded && _selectedIndex == index)
                              ? Icons.arrow_drop_down_circle
                              : Icons.arrow_drop_down,
                        ),
                        title: Text(
                          '${monthsInYear[attendence.month]}/${attendence.year}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Total Present: ${attendence.attendences?.length}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        children: [
                          BlocListener<UserBloc, UserState>(
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
                            child: GestureDetector(
                              onTap: () {
                                context.read<UserBloc>().add(
                                      GetAttendenceReportMonthlyEvent(
                                        id: widget.user.id ?? '',
                                        month: attendence.month ?? 0,
                                        year: attendence.year ?? 0,
                                      ),
                                    );
                              },
                              child: const Text(
                                'Download Report',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  color: Colors.black,
                                  thickness: 1,
                                );
                              },
                              shrinkWrap: true,
                              itemCount: attendence.attendences?.length ?? 0,
                              itemBuilder: (context, index) {
                                var attend = attendence.attendences?[index];

                                return ListTile(
                                  title: Row(
                                    children: [
                                      Text(
                                        '${attend?.createdAt?.toIso8601String().split('T').first}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        attend?.status?.toUpperCase() ?? '',
                                        style: TextStyle(
                                          color: attend?.status == 'present'
                                              ? Colors.green
                                              : Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      _inTimeController.text =
                                          attend?.inTime ?? '';
                                      _outTimeController.text =
                                          attend?.outTime ?? '';
                                      _statusController.text =
                                          attend?.status ?? '';
                                      // will open the dialog to edit the attendence
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Edit Attendence'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  controller: _inTimeController,
                                                  decoration: InputDecoration(
                                                    hintText: 'In Time',
                                                    label:
                                                        const Text('In Time'),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                TextFormField(
                                                  controller:
                                                      _outTimeController,
                                                  decoration: InputDecoration(
                                                    label:
                                                        const Text('Out Time'),
                                                    hintText: 'Out Time',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                TextFormField(
                                                  controller: _statusController,
                                                  decoration: InputDecoration(
                                                    label: const Text('Status'),
                                                    hintText: 'Status',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              BlocConsumer<UserBloc, UserState>(
                                                listener: (context, state) {
                                                  if (state.error.isNotEmpty) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content:
                                                            Text(state.error),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    );
                                                  }
                                                  if (state
                                                      .message.isNotEmpty) {
                                                    if (state.message ==
                                                        'Attendence updated successfully!') {
                                                      context
                                                          .read<UserBloc>()
                                                          .add(
                                                            GetAttendencesOfParticularUserEvent(
                                                                id: widget.user
                                                                        .id ??
                                                                    ''),
                                                          );
                                                    }
                                                    // ScaffoldMessenger.of(
                                                    //         context)
                                                    //     .showSnackBar(
                                                    //   SnackBar(
                                                    //     content:
                                                    //         Text(state.message),
                                                    //     backgroundColor:
                                                    //         Colors.green,
                                                    //   ),
                                                    // );
                                                  }
                                                },
                                                builder: (context, state) {
                                                  if (state.isLoading) {
                                                    return const CircularProgressIndicator();
                                                  }
                                                  return TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<UserBloc>()
                                                          .add(
                                                            UpdateAttendenceEvent(
                                                              id: attend?.id ??
                                                                  '',
                                                              inTime:
                                                                  _inTimeController
                                                                      .text,
                                                              outTime:
                                                                  _outTimeController
                                                                      .text,
                                                              status:
                                                                  _statusController
                                                                      .text,
                                                            ),
                                                          );

                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Update'),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${attend?.inTime ?? ''} - ${attend?.outTime ?? ''}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'Span ${attend?.duration ?? '0'}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
