import 'package:flutter/material.dart';
import 'package:rj/utils/cached_data.dart';

import '../../config/routes/route_names.dart';

class AccountsScreenServices {
  signOutToLoginScreen(BuildContext contextMain,BuildContext contextProgress) async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(contextProgress);
    CachedData.clearSharedPrefData();
    print("POPPED TO LOGIN");
    Navigator.pushNamed(contextMain, RouteNames.loginScreen);
  }
}