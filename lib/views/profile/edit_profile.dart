import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.details});

  final Map<String, dynamic> details;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.details['name'] ?? '';
    _emailController.text = widget.details['email'] ?? '';
    _phoneController.text = widget.details['phone'] ?? '';
    _departmentController.text = widget.details['department'] ?? '';
    _designationController.text = widget.details['designation'] ?? '';
    _organizationController.text = widget.details['organization'] ?? '';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _departmentController.dispose();
    _designationController.dispose();
    _organizationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String role = context.read<AuthBloc>().state.user.role ?? '';
    final String id = context.read<AuthBloc>().state.user.id ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
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
              if (state.message == 'User updated successfully!') {
                final String id = context.read<AuthBloc>().state.user.id ?? '';

                context.read<UserBloc>().add(GetAttendanceEvent(id: id));
                context.read<UserBloc>().add(GetLeavesEvent(id: id));
                context.read<UserBloc>().add(GetAllAttendencesEvent(id: id));

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
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // TextFeild for name
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _nameController.text = value;
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
                        maxLength: 30,
                        maxLines: 1,
                        controller: _nameController,
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
                          prefixIcon: const Icon(Icons.person),
                          labelText: 'Name',
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
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),

                      // TextFeild for phone
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _phoneController.text = value;
                          });
                        },
                        style: const TextStyle(color: Colors.black),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        ],
                        keyboardType: TextInputType.phone,
                        enableSuggestions: true,
                        autocorrect: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 10,
                        maxLines: 1,
                        controller: _phoneController,
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
                          prefixIcon: const Icon(Icons.phone),
                          labelText: 'Phone',
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
                            return 'Please enter phone number';
                          } else if (value.length <= 9) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),

                      // TextFeild for email
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _emailController.text = value;
                          });
                        },
                        autofillHints: const [AutofillHints.email],
                        style: const TextStyle(color: Colors.black),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _emailController,
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
                          prefixIcon: const Icon(Icons.email),
                          labelText: 'Email',
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
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      // Drop Dwon for department
                      DropdownButtonFormField(
                        //  value: _departmentController.text,
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
                          prefixIcon: const Icon(Icons.category),
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
                        // value: _designationController.text,
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
                          prefixIcon: const Icon(Icons.work),
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
                      role == 'company'
                          ? TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _organizationController.text = value;
                                });
                              },
                              style: const TextStyle(color: Colors.black),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-zA-Z]'))
                              ],
                              keyboardType: TextInputType.name,
                              enableSuggestions: true,
                              autocorrect: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLength: 30,
                              maxLines: 1,
                              controller: _organizationController,
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
                                prefixIcon: const Icon(Icons.factory),
                                labelText: 'Organization',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
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
                                  return 'Please enter your organization';
                                }
                                return null;
                              },
                            )
                          : const SizedBox(),
                      // SizedBox for spacing
                      const SizedBox(
                        height: 25,
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
                                    context.read<UserBloc>().add(
                                          UpdateUserEvent(
                                              id: id,
                                              name: _nameController.text,
                                              email: _emailController.text,
                                              phone: _phoneController.text,
                                              department:
                                                  _departmentController.text,
                                              designation:
                                                  _departmentController.text,
                                              organization:
                                                  _organizationController.text),
                                        );

                                    context.pop();
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
                                  'U P D A T E',
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
              ),
            );
          },
        ),
      ),
    );
  }
}
