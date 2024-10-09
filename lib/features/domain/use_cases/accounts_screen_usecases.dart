import 'package:flutter/material.dart';

import '../../../config/routes/route_names.dart';
import '../../data/data_sources/cached_data.dart';

class AccountScreenUsecases{
  signOutToLoginScreen(BuildContext contextMain,VoidCallback callback) async {
    await Future.delayed(const Duration(seconds: 1));
    CachedData.clearSharedPrefData();
    print("POPPED TO LOGIN");
    callback();
    Navigator.pushNamed(contextMain, RouteNames.loginScreen);
  }
  static navigateToEditProfileScreen(BuildContext context){
  }
  static navigateToAddAddressScreen(BuildContext context){
    print("object");
    Navigator.pushNamed(context, RouteNames.addAddressScreen);
  }
}