import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/config/routes/route_names.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/user_profile_model.dart';

import '../../data/models/products_model.dart';
import '../../presentation/screens/cart_screen/bloc/cart_bloc.dart';

class CartUseCase {
  static ValueNotifier<int> valQuantityNotifier = ValueNotifier(1);

  static int getTotalPrice(String sellingPrize, int? value) {
    int sellPrice = int.parse(sellingPrize);
    return sellPrice * value!;
  }

  static double getCartTotal(List<CartModel> cartList) {
    double cartTotal = 0.00;
    for (var item in cartList) {
      cartTotal = cartTotal + item.totalAmount;
    }
    return cartTotal;
  }

  static double discountAmt(double cartTotal, int discountPercentage) {
    double discountAmt = (cartTotal * discountPercentage) / 100;
    return discountAmt;
  }

  static double getLastTotalAmount(double cartTotal, double discountAmt) {
    return cartTotal - discountAmt;
  }

  updateQuantity(int value) {
    valQuantityNotifier.value = value;
  }

  static changeQuantity(CartModel productModel, List<String> listDialog,
      int index, BuildContext context) {
    if (productModel.cartedQuantity.toString() != listDialog[index]) {
      context.read<CartBloc>().add(CartUpdateEvent(
          value: int.parse(listDialog[index]),
          cartModel: productModel,
          context: context));
    }
  }

  static passDetailsToPlaceOrderScreen(BuildContext context,
      List<CartModel> cartList, UserProfileModel userModel,String lastPrice) {
    Map<String, dynamic> map =  {"cartList": cartList, "userModel": userModel,"lastPrice":lastPrice};
    Navigator.pushNamed(context, RouteNames.placeOrderScreen,
        arguments:map);
  }
}
