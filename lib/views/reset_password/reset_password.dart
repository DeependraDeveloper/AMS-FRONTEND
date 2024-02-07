import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // to hide keyboard when user click outside the textfield
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
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
              // context.read<PostBloc>().add(LoadPostsEvent(
              //       range:
              //           context.read<UserBloc>().state.user.range?.toDouble() ??
              //               5.0,
              //       userId: state.user.id ?? '',
              //       lat:
              //           context.read<LocationBloc>().state.position?.latitude ??
              //               0,
              //       long: context
              //               .read<LocationBloc>()
              //               .state
              //               .position
              //               ?.longitude ??
              //           0,
              //     ));
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
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/2.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                        prefixIconColor: const Color.fromARGB(255, 8, 121, 214),
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
                    // SizedBox for spacing
                    const SizedBox(
                      height: 14,
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
                        prefixIconColor: const Color.fromARGB(255, 8, 121, 214),
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
                            isObscure ? Icons.visibility_off : Icons.visibility,
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
                    // SizedBox for spacing
                    const SizedBox(
                      height: 14,
                    ),
                    // TextFeild for confirm password
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _confirmPasswordController.text = value;
                        });
                      },
                      style: const TextStyle(color: Colors.black),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _confirmPasswordController,
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
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(color: Colors.black),
                        prefixIconColor: const Color.fromARGB(255, 8, 121, 214),
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
                            isObscure ? Icons.visibility_off : Icons.visibility,
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
                                if (_formKey.currentState?.validate() == true) {
                                  context.read<AuthBloc>().add(
                                        ResetPasswordEvent(
                                          phone: int.parse(
                                              _phoneController.text.trim()),
                                          password:
                                              _passwordController.text.trim(),
                                          confirmPassword:
                                              _confirmPasswordController.text
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
                                'RESET PASSWORD',
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
    );
  }
}
