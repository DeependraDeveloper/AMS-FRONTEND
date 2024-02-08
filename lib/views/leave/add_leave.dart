import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddLeavePage extends StatefulWidget {
  const AddLeavePage({super.key});

  @override
  State<AddLeavePage> createState() => _AddLeavePageState();
}

class _AddLeavePageState extends State<AddLeavePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _leaveTypeController = TextEditingController();
  final TextEditingController _leaveReasonController = TextEditingController();
  final TextEditingController _leaveFromController = TextEditingController();
  final TextEditingController _leaveToController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Add Leave Request',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state.error.isNotEmpty == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              );
            } else if (state.message.isNotEmpty == true) {
              if (state.message == 'Leave request submitted successfully!') {
                context.pop();
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.green,
                        ),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // DropdownButtonFormField for leave type
                      DropdownButtonFormField(
                        borderRadius: BorderRadius.circular(20),
                        decoration: InputDecoration(
                          floatingLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          prefixIcon: const Icon(Icons.category_outlined),
                          labelText: 'Leave Type',
                          labelStyle: const TextStyle(color: Colors.black),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          prefixIconColor:
                              const Color.fromARGB(255, 8, 121, 214),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Casual Leave',
                            child: Text('Casual Leave'),
                          ),
                          DropdownMenuItem(
                            value: 'Sick Leave',
                            child: Text('Sick Leave'),
                          ),
                          DropdownMenuItem(
                            value: 'Privilege Leave',
                            child: Text('Privilege Leave'),
                          ),
                          DropdownMenuItem(
                            value: 'Maternity Leave',
                            child: Text('Maternity Leave'),
                          ),
                          DropdownMenuItem(
                            value: 'Paternity Leave',
                            child: Text('Paternity Leave'),
                          ),
                          DropdownMenuItem(
                            value: 'Compensatory Leave',
                            child: Text('Compensatory Leave'),
                          ),
                          DropdownMenuItem(
                            value: 'Others',
                            child: Text('Others'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _leaveTypeController.text = value.toString();
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter leave to';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      // TextFeild for leave reason
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _leaveReasonController.text = value;
                          });
                        },
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.name,
                        enableSuggestions: true,
                        autocorrect: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 30,
                        maxLines: 1,
                        controller: _leaveReasonController,
                        decoration: InputDecoration(
                          floatingLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          prefixIcon: const Icon(Icons.email_outlined),
                          labelText: 'Leave Reason',
                          labelStyle: const TextStyle(color: Colors.black),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          prefixIconColor:
                              const Color.fromARGB(255, 8, 121, 214),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter leave reason';
                          }
                          return null;
                        },
                      ),

                      // TextFeild for leave from
                      TextFormField(
                        readOnly: true,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050, 12, 31),
                            initialDate: _leaveFromController.text.isNotEmpty
                                ? DateTime.parse(_leaveFromController.text)
                                : DateTime.now(),
                          ).then(
                            (value) {
                              if (value != null) {
                                setState(
                                  () {
                                    _leaveFromController.text = value
                                        .toIso8601String()
                                        .split('T')
                                        .first
                                        .toString();
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _leaveFromController,
                        decoration: InputDecoration(
                          floatingLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          prefixIcon: const Icon(Icons.calendar_today_outlined),
                          labelText: 'Leave From',
                          labelStyle: const TextStyle(color: Colors.black),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          prefixIconColor:
                              const Color.fromARGB(255, 8, 121, 214),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter leave from';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // TextFeild for leave to
                      TextFormField(
                        readOnly: true,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050, 12, 31),
                            initialDate: _leaveToController.text.isNotEmpty
                                ? DateTime.parse(_leaveToController.text)
                                : DateTime.now(),
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                _leaveToController.text = value
                                    .toIso8601String()
                                    .split('T')
                                    .first
                                    .toString();
                              });
                            }
                          });
                        },
                        style: const TextStyle(color: Colors.black),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _leaveToController,
                        decoration: InputDecoration(
                          floatingLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          // when the TextFormField in focused or clicked
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // when the TextFormField in not focused or clicked
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // border for TextFormField
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          prefixIcon: const Icon(Icons.calendar_today_outlined),
                          labelText: 'Leave To',
                          labelStyle: const TextStyle(color: Colors.black),
                          prefixIconColor:
                              const Color.fromARGB(255, 8, 121, 214),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter leave to';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      // Text Button for next and send the data to the next page
                      state.isLoading
                          ? const CircularProgressIndicator()
                          : TextButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() == true) {
                                  context.read<UserBloc>().add(
                                        AddLeaveRequestEvent(
                                          leaveType: _leaveTypeController.text,
                                          leaveReason:
                                              _leaveReasonController.text,
                                          leaveFrom: _leaveFromController.text,
                                          leaveTo: _leaveToController.text,
                                          id: context
                                                  .read<AuthBloc>()
                                                  .state
                                                  .user
                                                  .id ??
                                              '',
                                        ),
                                      );
                                }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 8, 121, 214),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'SUBMIT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
