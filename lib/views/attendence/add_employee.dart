import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Add Employee',
          style: TextStyle(color: Colors.black),
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
                      const SizedBox(height: 20),
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

                      // TextFeild for email
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _emailController.text = value;
                          });
                        },
                        style: const TextStyle(color: Colors.black),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9@.]'))
                        ],
                        keyboardType: TextInputType.name,
                        enableSuggestions: true,
                        autocorrect: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 30,
                        maxLines: 1,
                        controller: _emailController,
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
                          prefixIcon: const Icon(Icons.email),
                          labelText: 'Email',
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
                            return 'Please enter your email';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email';
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

                      // TextFeild for password
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _passwordController.text = value;
                          });
                        },
                        style: const TextStyle(color: Colors.black),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _passwordController,
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
                          prefixIcon: const Icon(Icons.lock),
                          labelText: 'Password',
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
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                              () => isObscure = !isObscure,
                            ),
                            icon: Icon(
                              isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color.fromARGB(255, 8, 121, 214),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isObscure,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // DropDwon for department
                      DropdownButtonFormField(
                        dropdownColor: Colors.blue,
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

                      const SizedBox(
                        height: 20,
                      ),

                      // Text Button for next and send the data to the next page
                      state.isLoading
                          ? const CircularProgressIndicator()
                          : TextButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() == true) {
                                  final String id =
                                      context.read<AuthBloc>().state.user.id ??
                                          '';
                                  context.read<UserBloc>().add(
                                        AddEmployeeEvent(
                                          id: id,
                                          name: _nameController.text,
                                          email: _emailController.text,
                                          phone: _phoneController.text,
                                          password: _passwordController.text,
                                          department:
                                              _departmentController.text,
                                          designation:
                                              _designationController.text,
                                        ),
                                      );

                                  context.pop();
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
                                'Next',
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
