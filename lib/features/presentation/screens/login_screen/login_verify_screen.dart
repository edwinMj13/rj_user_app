import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/config/routes/route_names.dart';
import 'package:rj/features/services/login_services.dart';
import 'package:rj/utils/cached_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/styles.dart';
import '../../../data/models/user_profile_model.dart';
import '../../widgets/big_text.dart';
import '../../widgets/right_arrow_ios.dart';
import 'bloc/auth_bloc.dart';

class LoginVerifyScreen extends StatelessWidget {
  const LoginVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthSuccessState) {
              LoginServices.passDataNavigateToAddress(state, context);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextHeadAndSubText(),
                InputNumber(),
                GoogleAuthSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

class InputNumber extends StatelessWidget {
  const InputNumber({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Enter Number",
          ),
        ),
        sizedH30,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            RightArrowIOS(
              pressFunction: () => submitForOtp(context),
            ),
          ],
        ),
      ],
    );
  }
}

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
        context.read<AuthBloc>().add(SignInEvent());
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
}
