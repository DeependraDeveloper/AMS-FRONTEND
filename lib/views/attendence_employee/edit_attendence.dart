import 'package:amsystm/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAttendencePage extends StatefulWidget {
  const EditAttendencePage({super.key});

  @override
  State<EditAttendencePage> createState() => _EditAttendencePageState();
}

class _EditAttendencePageState extends State<EditAttendencePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateRangeController = TextEditingController();

  final TextEditingController _inTimeController = TextEditingController();
  final TextEditingController _outTimeController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  void dispose() {
    _dateRangeController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String id = context.read<UserBloc>().state.user.id ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Attendence'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
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

            return Column(
              children: [
                // search filter to get attendence of particular date
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            readOnly: true,
                            onTap: () {
                              showDateRangePicker(
                                context: context,
                                firstDate: DateTime(2024, 1, 1),
                                lastDate: DateTime(2050, 12, 31),
                                initialDateRange: DateTimeRange(
                                  start: DateTime.now(),
                                  end: DateTime.now(),
                                ),
                              ).then(
                                (value) {
                                  if (value != null) {
                                    setState(
                                      () {
                                        _dateRangeController.text =
                                            '${value.start.toIso8601String().split('T').first} TO ${value.end.toIso8601String().split('T').first}';
                                      },
                                    );
                                  }
                                },
                              );
                            },
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.name,
                            enableSuggestions: true,
                            autocorrect: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _dateRangeController,
                            decoration: InputDecoration(
                              floatingLabelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              prefixIcon:
                                  const Icon(Icons.calendar_today_outlined),
                              labelText: 'Attendence Date Range',
                              labelStyle: const TextStyle(color: Colors.black),
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIconColor:
                                  const Color.fromARGB(255, 8, 121, 214),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select date range';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState?.validate() == true) {
                            context.read<UserBloc>().add(
                                  GetAttendenceWithDateRangeEvent(
                                    id: id,
                                    startDate: _dateRangeController.text
                                        .split(' TO ')
                                        .first
                                        .trim(),
                                    endDate: _dateRangeController.text
                                        .split(' TO ')
                                        .last
                                        .trim(),
                                  ),
                                );
                          }
                        },
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 8, 121, 214),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'Find',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                (state.dateRangeAttendences.isEmpty)
                    ? const Center(
                        child: Text(
                          'Select date range to get attendence',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Update All Attendences',
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: _inTimeController,
                                            decoration: InputDecoration(
                                              hintText: 'HH:MM:SS AM',
                                              label: const Text('In Time'),
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
                                            controller: _outTimeController,
                                            decoration: InputDecoration(
                                              label: const Text('Out Time'),
                                              hintText: 'HH:MM:SS PM',
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
                                              hintText: 'presnt|absent',
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
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(state.error),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                            if (state.message.isNotEmpty) {
                                              if (state.message ==
                                                  'Attendence updated successfully!') {
                                                // context.read<UserBloc>().add(
                                                //       GetAttendencesOfParticularUserEvent(
                                                //           id: widget.user.id ??
                                                //               ''),
                                                //     );
                                              }
                                              // ScaffoldMessenger.of(context)
                                              //     .showSnackBar(
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
                                            return TextButton(
                                              onPressed: () {
                                                final List<String> ids = state
                                                    .dateRangeAttendences
                                                    .map((e) => e.id ?? '')
                                                    .toList();

                                                context.read<UserBloc>().add(
                                                      UpdateAttendencesEvent(
                                                        ids: ids,
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

                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Update'),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );

                                //
                              },
                              child: const Text(
                                'Update All',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 8, 121, 214),
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.dateRangeAttendences.length,
                                itemBuilder: (context, index) {
                                  var attendence =
                                      state.dateRangeAttendences[index];

                                  return Card(
                                    color: Colors.grey[200],
                                    child: ListTile(
                                      title: Text(attendence.user?.name ?? ''),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            attendence.createdAt
                                                    ?.toIso8601String()
                                                    .split('T')
                                                    .first ??
                                                '',
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                attendence.inTime ?? '',
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                attendence.outTime ?? '',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            attendence.status?.toUpperCase() ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color:
                                                  attendence.status == 'present'
                                                      ? Colors.green
                                                      : Colors.red,
                                            ),
                                          ),
                                          Text(attendence.duration ?? ''),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
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
