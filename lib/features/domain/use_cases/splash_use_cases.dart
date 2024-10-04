import 'package:flutter/material.dart';

import '../../../config/routes/route_names.dart';
import '../../../utils/dependencyLocation.dart';
import '../../data/repository/auth_repository.dart';

class SplashUseCases {
  static ifLoggedIn(BuildContext context)async{
    final isLogged = await locator<AuthRepository>().isLoggedIn();
    print("delay $isLogged");
    Future.delayed(const Duration(seconds: 2)).then((_){
      if( isLogged){
        Navigator.pushNamedAndRemoveUntil(context, RouteNames.mainScreen,(route)=>false);
      }else{
        Navigator.pushNamedAndRemoveUntil(context, RouteNames.loginScreen,(route)=>false);
      }
    });

  }
}