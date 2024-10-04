import 'package:flutter/material.dart';
import 'package:rj/config/routes/route_names.dart';
import 'package:rj/features/domain/use_cases/splash_use_cases.dart';
import 'package:rj/utils/dependencyLocation.dart';

import '../../../data/repository/auth_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState;
    super.initState();
    SplashUseCases.ifLoggedIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: CircleAvatar(
          radius: 50,
          child: Image.asset("assets/app_icon.jpg"),
        ),
      ),
    );
  }


}
