import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterTwo extends StatefulWidget {
  const RegisterTwo({
    super.key,
    required this.details,
  });

  final Map<String, dynamic> details;

  @override
  State<RegisterTwo> createState() => _RegisterTwoState();
}

class _RegisterTwoState extends State<RegisterTwo> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/3.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocConsumer<AuthBloc, AuthState>(
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
                margin: const EdgeInsets.symmetric(horizontal: 5),
                color: Colors.transparent,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Drop Dwon for department

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
                          prefixIcon: const Icon(Icons.ads_click_outlined),
                          labelText: 'Department',
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
                            value: 'IT',
                            child: Text('IT'),
                          ),
                          DropdownMenuItem(
                            value: 'HR',
                            child: Text('HR'),
                          ),
                          DropdownMenuItem(
                            value: 'Marketing',
                            child: Text('Marketing'),
                          ),
                          DropdownMenuItem(
                            value: 'Sales',
                            child: Text('Sales'),
                          ),
                          DropdownMenuItem(
                            value: 'Finance',
                            child: Text('Finance'),
                          ),
                          DropdownMenuItem(
                            value: 'Operations',
                            child: Text('Operations'),
                          ),
                          DropdownMenuItem(
                            value: 'Design',
                            child: Text('Design'),
                          ),
                          DropdownMenuItem(
                            value: 'Others',
                            child: Text('Others'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _departmentController.text = value.toString();
                          });
                        },
                      ),

                      const SizedBox(height: 20),
                      // DropDwon for designation
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
                          prefixIcon: const Icon(Icons.ads_click_outlined),
                          labelText: 'Designation',
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
                            value: 'Manager',
                            child: Text('Manager'),
                          ),
                          DropdownMenuItem(
                            value: 'Team Lead',
                            child: Text('Team Lead'),
                          ),
                          DropdownMenuItem(
                            value: 'Developer',
                            child: Text('Developer'),
                          ),
                          DropdownMenuItem(
                            value: 'Designer',
                            child: Text('Designer'),
                          ),
                          DropdownMenuItem(
                            value: 'Tester',
                            child: Text('Tester'),
                          ),
                          DropdownMenuItem(
                            value: 'Others',
                            child: Text('Others'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _designationController.text = value.toString();
                          });
                        },
                      ),

                      const SizedBox(height: 20),
                      // TextFeild for organization
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _organizationController.text = value;
                          });
                        },
                        style: const TextStyle(color: Colors.black),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                        ],
                        keyboardType: TextInputType.name,
                        enableSuggestions: true,
                        autocorrect: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 10,
                        maxLines: 1,
                        controller: _organizationController,
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
                          prefixIcon: const Icon(Icons.account_balance),
                          labelText: 'Organization',
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
                            return 'Please enter your organization';
                          }
                          return null;
                        },
                      ),

                      // Bitton for login with gradient color and rounded border

                      state.isLoading
                          ? const CircularProgressIndicator()
                          : Container(
                              width: double.infinity,
                              height: 50,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  colors: [
                                    Color.fromARGB(255, 3, 116, 244),
                                    Color.fromARGB(255, 3, 67, 119),
                                  ],
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    context.read<AuthBloc>().add(
                                          SignUpEvent(
                                            phone:
                                                widget.details['phone'] ?? '',
                                            password:
                                                widget.details['password'] ??
                                                    '',
                                            name: widget.details['name'] ?? '',
                                            email:
                                                widget.details['email'] ?? '',
                                            department: _departmentController
                                                .text
                                                .trim(),
                                            designation: _designationController
                                                .text
                                                .trim(),
                                            organization:
                                                _organizationController.text
                                                    .trim(),
                                          ),
                                        );
                                  } else {
                                    final errorMessage =
                                        context.read<AuthBloc>().state.message;
                                    if (errorMessage.isNotEmpty) {
                                      final snackBar = SnackBar(
                                        content: Text(
                                          errorMessage,
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  }
                                },
                                child: const Text(
                                  'REGISTER',
                                  style: TextStyle(
                                    letterSpacing: 1.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
