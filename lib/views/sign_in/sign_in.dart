import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

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
              if (state.message == 'Signed In Successfully!') {
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/1.png'),
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
                      height: 20,
                    ),
                    // TextFeild for password with validation and outline border and prefix icon of lock
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _passwordController.text = value;
                        });
                      },
                      autofillHints: const [AutofillHints.telephoneNumber],
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
                                        SignInEvent(
                                          phone: int.parse(
                                              _phoneController.text.trim()),
                                          password:
                                              _passwordController.text.trim(),
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
                                'SIGN IN',
                                style: TextStyle(
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                    // SizedBox for spacing
                    const SizedBox(
                      height: 20,
                    ),

                    Container(
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
                          context.pushNamed('sign_up');
                        },
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                            letterSpacing: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    // SizedBox for spacing
                    const SizedBox(
                      height: 20,
                    ),

                    // Text for forgot password
                    GestureDetector(
                      onTap: () {
                        context.pushNamed('reset_password');
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
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
