import 'package:amsystm/views/signUp/register_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class RegisterOne extends StatefulWidget {
  const RegisterOne({super.key});

  @override
  State<RegisterOne> createState() => _RegisterOneState();
}

class _RegisterOneState extends State<RegisterOne> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/reset_password.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    prefixIconColor: const Color.fromARGB(255, 8, 121, 214),
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
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9@.]'))
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
                    prefixIconColor: const Color.fromARGB(255, 8, 121, 214),
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

                const SizedBox(
                  height: 20,
                ),

                // Text Button for next and send the data to the next page
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.pushNamed(
                        'register',
                        extra: {
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'phone': int.parse(_phoneController.text),
                          'password': _passwordController.text,
                        },
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 8, 121, 214),
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
      ),
    );
  }
}
