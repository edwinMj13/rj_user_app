import 'package:flutter/material.dart';
import 'package:rj/utils/cached_data.dart';

import '../../config/routes/route_names.dart';

class AccountsScreenServices {
  signOutToLoginScreen(BuildContext contextMain,VoidCallback callback) async {
    await Future.delayed(const Duration(seconds: 1));
    CachedData.clearSharedPrefData();
    print("POPPED TO LOGIN");
    callback();
    Navigator.pushNamed(contextMain, RouteNames.loginScreen);
  }
}