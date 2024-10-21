import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/features/data/repository/cart_repository.dart';

import '../../../config/routes/route_names.dart';
import '../../../utils/dependencyLocation.dart';
import '../../data/models/cart_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../presentation/screens/home_screen/bloc/home_bloc.dart';
import '../../presentation/screens/main_screen/bloc/main_bloc.dart';

class SplashUseCases {
  static ifLoggedIn(BuildContext context)async{
    List<CartModel> cartLength=[];
    final isLogged = await locator<AuthRepository>().isLoggedIn();
    final user = await CachedData.getUserDetails();
    if(user.nodeID.isNotEmpty) {
       cartLength = await locator<CartRepository>().getCarts(user.nodeID);
    }
    print("delay $isLogged");
    Future.delayed(const Duration(seconds: 2)).then((_){
      if( isLogged){
        context.read<HomeBloc>().add(FetchDataHomeEvent());
        Navigator.pushNamedAndRemoveUntil(context, RouteNames.mainScreen,arguments:cartLength.length, (route)=>false);
      }else{
        Navigator.pushNamedAndRemoveUntil(context, RouteNames.loginScreen,(route)=>false);
      }
    });

  }
}