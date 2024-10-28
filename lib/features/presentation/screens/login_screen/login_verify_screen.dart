import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/config/routes/route_names.dart';
import 'package:rj/features/domain/use_cases/login_case.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/features/domain/use_cases/show_loading_with_out_text.dart';
import 'package:rj/utils/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/dependencyLocation.dart';
import '../../../../utils/styles.dart';
import '../../../data/models/cart_model.dart';
import '../../../data/models/user_profile_model.dart';
import '../../../data/repository/cart_repository.dart';
import '../../widgets/big_text.dart';
import '../../widgets/right_arrow_ios.dart';
import '../home_screen/bloc/home_bloc.dart';
import 'bloc/auth_bloc.dart';

class LoginVerifyScreen extends StatelessWidget {
  LoginVerifyScreen({super.key});

  final ShowLoadingWithOutCase loadingBar = ShowLoadingWithOutCase();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            print("Login State ${state.runtimeType}");
            if (state is AuthSuccessState) {
              loadingBar.cancelLoading();
              LoginCase.passDataNavigateToAddress(state, context);
            } else if (state is AuthUserInDatabaseState) {
              loadingBar.cancelLoading();
              LoginCase.alreadHaveAccount(context, state.user);
            } else if (state is AuthPendingState) {
              loadingBar.showLoadingWithout(context);
            } else if (state is AuthErrorState) {
              loadingBar.cancelLoading();
              Future.delayed(Duration(milliseconds: 500)).then((_){
                snackbar(context, state.message);
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const BigTextLogin(text: "Login"),
                InputNumber(),
                _actionButtons(context),
                // TextHeadAndSubText(),
                // GoogleAuthSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _actionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.signUpScreen);
          },
          child: const Text('Sign Up'),
        ),
      ],
    );
  }
}

/*
class GoogleAuthSection extends StatelessWidget {
  const GoogleAuthSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "or",
            style: style(
                fontSize: 13, color: Colors.grey, weight: FontWeight.normal),
          ),
          sizedH30,
          const GoogleSignUpButton(),
        ],
      ),
    );
  }
}
*/
class InputNumber extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  InputNumber({
    super.key,
  });
  final _loginForm = GlobalKey<FormState>();

  validate(){
    final isTrue = _loginForm.currentState!.validate();
    if(isTrue){
      return true;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginForm,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value){
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
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value){
              if(value==null || value.isEmpty ){
                return "Enter Password";
              }
              return null;
            },
          ),

          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                if(validate()){
                  context.read<AuthBloc>().add(LogInEvent(
                    context: context,
                    email: emailController.text.trim(),
                    password: passwordController.text,
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Login'),
            ),
          ),
          sizedH20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              TextButton(onPressed: () =>Navigator.pushNamed(context,RouteNames.forgotPasswordScreen), child: Text("Forgot Password"))
            ],
          ),
          // const TextField(
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(),
          //     labelText: "Enter Number",
          //   ),
          // ),
          // sizedH30,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const SizedBox(),
          //     RightArrowIOS(
          //       pressFunction: () => submitForOtp(context),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
/*
submitForOtp(BuildContext context) {
  ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text("OTP Sent")));
}

class TextHeadAndSubText extends StatelessWidget {
  const TextHeadAndSubText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BigTextLogin(text: "Login"),
        sizedH30,
        Text(
          "We\'ll send an OTP to this mobile number",
          style: style(
              fontSize: 14, color: Colors.black38, weight: FontWeight.normal),
        ),
      ],
    );
  }
}

class GoogleSignUpButton extends StatelessWidget {
  const GoogleSignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AuthBloc>().add(SignInEvent(context: context));
      },
      child: Container(
        height: 60,
        width: 230,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white70,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 5)
            ]),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            print(state.runtimeType);
            if (state is AuthPendingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/google_icon.png'),
                  sizedW20,
                  Text(
                    "Signup With Google",
                    style: style(
                        fontSize: 14,
                        color: Colors.grey,
                        weight: FontWeight.normal),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}*/
