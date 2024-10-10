import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/presentation/screens/wish_list_screen/bloc/wish_list_bloc.dart';

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

  static navigateToOrdersScreen(BuildContext context){
    print("object");
    //Navigator.pushNamed(context, RouteNames.addAddressScreen);
  }

  static navigateToWishListScreen(BuildContext context){
    context.read<WishListBloc>().add(FetchWishListedItems());
    Navigator.pushNamed(context, RouteNames.wishListScreen);
  }

  static navigateToContactUsScreen(BuildContext context){
    print("object");
   // Navigator.pushNamed(context, RouteNames.addAddressScreen);
  }

  static navigateToCouponsScreen(BuildContext context){
    print("object");
   // Navigator.pushNamed(context, RouteNames.addAddressScreen);
  }
}