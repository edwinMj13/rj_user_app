import 'package:flutter/material.dart';

import '../../config/routes/route_names.dart';
import '../../utils/cached_data.dart';
import '../data/models/user_profile_model.dart';
import '../presentation/screens/login_screen/bloc/auth_bloc.dart';

class LoginServices {
  static passDataNavigateToAddress(AuthSuccessState stateData, BuildContext context) async {
    final userData = UserProfileModel(
      nodeID: "",
      uid: stateData.user.uid,
      name: stateData.user.displayName!,
      phoneNumber: stateData.user.phoneNumber ?? "",
      email: stateData.user.email!,
      billingAddress: "",
      shippingAddress: "",
    );
    await CachedData.addProfileData(stateData);
    Navigator.pushNamed(context, RouteNames.addAddressScreen,
        arguments: userData);
  }
}