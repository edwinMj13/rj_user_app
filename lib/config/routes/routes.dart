import 'package:flutter/material.dart';
import 'package:rj/features/presentation/screens/category_details_screen/category_details_screen.dart';
import 'package:rj/features/presentation/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:rj/features/presentation/screens/main_screen/main_screen.dart';
import 'package:rj/features/presentation/screens/product_details/product_details_screen.dart';

import '../../features/presentation/screens/add_address_screen/add_address_screen.dart';
import '../../features/presentation/screens/add_details_screen/add_details_screen.dart';
import '../../features/presentation/screens/login_screen/login_verify_screen.dart';
import '../../features/presentation/screens/splash_screen/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    print("settings.arguments ${settings.arguments}");
    switch (settings.name) {
      case "splash_screen":
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case "main_screen":
        return MaterialPageRoute(
            builder: (context) => const MainScreen(), settings: settings);
      case "login_screen":
        return MaterialPageRoute(
            builder: (context) => const LoginVerifyScreen());
      case "add_details_screen":
        return MaterialPageRoute(
            builder: (context) => AddDetailsScreen(), settings: settings);
      case "product_details_screen":
        return MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(), settings: settings);
      case "category_details_screen":
        //String? categoryTitle = settings.arguments.toString();
        return MaterialPageRoute(
            builder: (context) => CategoryDetailsScreen(
                  categoryName: settings.arguments.toString(),
                ),
            settings: settings);
      case "add_address_screen":
        return MaterialPageRoute(builder: (context) => AddAddressScreen());
      case "edit_profile_screen":
        return MaterialPageRoute(builder: (context) => EditProfileScreen());
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(
                    child: Text("No Route Generated"),
                  ),
                ));
    }
  }
}
