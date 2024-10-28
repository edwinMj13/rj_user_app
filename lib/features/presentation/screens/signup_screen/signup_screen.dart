import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/repository/auth_repository.dart';
import 'package:rj/features/presentation/screens/signup_screen/bloc/signup_bloc.dart';
import 'package:rj/utils/dependencyLocation.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();

  validate() {
    final isTrue = _signUpFormKey.currentState!.validate();
    if (isTrue) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Create an Account',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    _textFieldActions(context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Navigate back to Login screen
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Form _textFieldActions(BuildContext context) {
    return Form(
      key: _signUpFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),

          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter Name";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          // Email Input Field
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value.trim())) {
                return 'Enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          // Password Input Field
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter Password";
              }
              return null;
            },
          ),

          const SizedBox(height: 40),
          // Sign Up Button
          ElevatedButton(
            onPressed: () {
              // Handle signup logic here
              if (validate()) {
                String name = nameController.text;
                String email = emailController.text;
                String password = passwordController.text;
                context.read<SignupBloc>().add(SignUpUserEvent(
                    name: name,
                    email: email,
                    password: password,
                    context: context));
              }
              // print('Name: $name, Email: $email, Password: $password');
            },
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Sign Up'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
