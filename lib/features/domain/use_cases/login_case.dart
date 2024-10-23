import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/routes/route_names.dart';
import '../../../utils/dependencyLocation.dart';
import '../../data/data_sources/cached_data.dart';
import '../../data/models/cart_model.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/repository/cart_repository.dart';
import '../../presentation/screens/home_screen/bloc/home_bloc.dart';
import '../../presentation/screens/login_screen/bloc/auth_bloc.dart';

class LoginCase {
  static passDataNavigateToAddress(
      AuthSuccessState stateData, BuildContext context) async {
    final userData = UserProfileModel(
      nodeID: "",
      uid: stateData.user.uid.toString(),
      name: stateData.user.displayName!,
      phoneNumber: stateData.user.phoneNumber ?? "",
      email: stateData.user.email!,
      pincode: "",
      shippingAddress: "",
    );
    await CachedData.addProfileData(stateData);
    Navigator.pushNamed(context, RouteNames.addDetailsScreen,
        arguments: userData);
  }

  static alreadHaveAccount(
      BuildContext context, UserProfileModel userProfile) async {
    List<CartModel> cartLength =
        await locator<CartRepository>().getCarts(userProfile.nodeID);
    context.read<HomeBloc>().add(FetchDataHomeEvent());
    Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.mainScreen,
        arguments: cartLength.length,
        (route) => false);
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('name', userProfile.name);
    await sharedPref.setString('email', userProfile.email);
    await sharedPref.setString('phoneNumber', userProfile.phoneNumber);
    CachedData.saveUserNode(userProfile.nodeID, userProfile.shippingAddress!,
        userProfile.pincode, userProfile.phoneNumber);
  }
}
