import 'package:flutter/material.dart';
import 'package:rj/features/data/models/brand_model.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/order_cart_purchase_model.dart';
import 'package:rj/features/data/models/order_model.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/presentation/screens/add_address_with_map_screen/add_address_with_map_screen.dart';
import 'package:rj/features/presentation/screens/brand_details_screen/brand_details_screen.dart';
import 'package:rj/features/presentation/screens/category_details_screen/category_details_screen.dart';
import 'package:rj/features/presentation/screens/change_address_screen/change_address_screen.dart';
import 'package:rj/features/presentation/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:rj/features/presentation/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:rj/features/presentation/screens/main_screen/main_screen.dart';
import 'package:rj/features/presentation/screens/order_details_screen/order_details_screen.dart';
import 'package:rj/features/presentation/screens/order_list_screen/order_list_screen.dart';
import 'package:rj/features/presentation/screens/place_order_screen/place_order_screen.dart';
import 'package:rj/features/presentation/screens/product_details/product_details_screen.dart';
import 'package:rj/features/presentation/screens/search_screen/search_screen.dart';
import 'package:rj/features/presentation/screens/signup_screen/signup_screen.dart';
import 'package:rj/features/presentation/screens/success_screen/success_screen.dart';
import 'package:rj/features/presentation/screens/wish_list_screen/wish_list_screen.dart';

import '../../features/presentation/screens/add_address_screen/add_address_screen.dart';
import '../../features/presentation/screens/add_details_screen/add_details_screen.dart';
import '../../features/presentation/screens/contact_us _screen/contact_us_screen.dart';
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
      case "forgot_password_screen":
        return MaterialPageRoute(
            builder: (context) =>  ForgotPasswordScreen());
      case "login_screen":
        return MaterialPageRoute(
            builder: (context) =>  LoginVerifyScreen());
      case "sign_up_screen":
        return MaterialPageRoute(
            builder: (context) =>  SignupScreen());
      case "add_details_screen":
        return MaterialPageRoute(
            builder: (context) => AddDetailsScreen(), settings: settings);
      case "product_details_screen":
        return MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
                  productModel: settings.arguments as ProductsModel,
                ),
            settings: settings);
      case "category_details_screen":
        return MaterialPageRoute(
            builder: (context) => CategoryDetailsScreen(
                  categoryName: settings.arguments.toString(),
                ),
            settings: settings);
      case "add_address_screen":
        return MaterialPageRoute(builder: (context) => AddAddressScreen());
      case "brand_details_screen":
        return MaterialPageRoute(builder: (context) => BrandDetailsScreen(brandModel: settings.arguments as BrandModel));
      case "search_screen":
        return MaterialPageRoute(builder: (context) => SearchScreen());
      case "add_address_with_map_screen":
        return MaterialPageRoute(builder: (context) => AddAddressWithMapScreen());
      case "contact_us_screen":
        return MaterialPageRoute(builder: (context) => ContactUsScreen());
      case "edit_profile_screen":
        return MaterialPageRoute(
            builder: (context) =>  EditProfileScreen(user: settings.arguments as UserProfileModel,));
      case "wish_list_screen":
        return MaterialPageRoute(builder: (context) => const WishListScreen());
      case "payment_success_screen":
        final mapData = settings.arguments as Map<String, dynamic>;
        final cartList = mapData["cartList"];
        final userModel = mapData["user"];
        final priceBreakup = mapData["priceBreakup"];
        final paymentId = mapData["payment_id"];
        return MaterialPageRoute(
            builder: (context) => SuccessScreen(
                  userModel: userModel,
                  cartList: cartList,
                  paymentId: paymentId,
                  priceBreakup: priceBreakup,
                ));
      case "place_order_screen":
        final mapData = settings.arguments as Map<String, dynamic>;
        final cartList = mapData["cartList"];
        final userModel = mapData["userModel"];
        final priceBreakup = mapData["priceBreakup"];
        //final tag = mapData["tag"];
        print(cartList);
        return MaterialPageRoute(
            builder: (context) => PlaceOrderScreen(
                  user: userModel,
                  cartList: cartList,
                  priceBreakup: priceBreakup,
                ));
      case "change_address_screen":
        return MaterialPageRoute(
            builder: (context) => ChangeAddressScreen(
                  userModel: settings.arguments as UserProfileModel,
                ));
      case "order_list_screen":
        return MaterialPageRoute(
            builder: (context) => const OrderListScreen());
      case "order_details_screen":
        final mapData = settings.arguments as Map<String, dynamic>;
    final priceBreakup = mapData["priceBreakup"];
    final modelList = mapData["purchaseCart"];
    final invNo = mapData["invNo"];
        return MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(purchasedCartList: modelList,priceBreakup: priceBreakup,invNo:invNo,));
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
