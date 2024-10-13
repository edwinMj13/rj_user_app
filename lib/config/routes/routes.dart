import 'package:flutter/material.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/presentation/screens/category_details_screen/category_details_screen.dart';
import 'package:rj/features/presentation/screens/change_address_screen/change_address_screen.dart';
import 'package:rj/features/presentation/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:rj/features/presentation/screens/main_screen/main_screen.dart';
import 'package:rj/features/presentation/screens/place_order_screen/place_order_screen.dart';
import 'package:rj/features/presentation/screens/product_details/product_details_screen.dart';
import 'package:rj/features/presentation/screens/wish_list_screen/wish_list_screen.dart';

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
            builder: (context) => ProductDetailsScreen(productModel: settings.arguments as ProductsModel,), settings: settings);
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
      case "wish_list_screen":
        return MaterialPageRoute(builder: (context) => WishListScreen());
      case "place_order_screen":
        final mapData = settings.arguments as Map<String, dynamic>;
        final cartList =  mapData["cartList"];
        final userModel =  mapData["userModel"];
        final lastPrice =  mapData["lastPrice"];
        print(cartList);
        return MaterialPageRoute(builder: (context) => PlaceOrderScreen(user: userModel,cartList: cartList,lastPrice: lastPrice,));
      case "change_address_screen":
        //final mapData = settings.arguments as Map<String, dynamic>;
        // final addressModelCallback =  mapData["addressModelCallback"];
        // final userModel =  mapData["userModel"];
        return MaterialPageRoute(builder: (context) =>  ChangeAddressScreen(userModel: settings.arguments as UserProfileModel,));
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
