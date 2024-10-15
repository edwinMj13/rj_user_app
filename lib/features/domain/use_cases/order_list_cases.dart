import 'package:flutter/cupertino.dart';
import 'package:rj/config/routes/route_names.dart';
import 'package:rj/features/data/repository/order_list_respository.dart';

import '../../../utils/dependencyLocation.dart';
import '../../data/models/cart_model.dart';
import '../../data/models/order_model.dart';
import '../../data/models/user_profile_model.dart';
import 'common_use_cases.dart';

class OrderListCases {



  static navigateToOrderDetailsScreen(BuildContext context,String orderId){
    Navigator.pushNamed(context, RouteNames.orderDetailsScreen,arguments: orderId);
  }

  static addOrderDetails(List<CartModel> cartList,UserProfileModel user,Map<String,dynamic> priceBreakup,BuildContext context) async {
    final orderModel = OrderModel(
      userNodeId: user.nodeID,
      orderNodeId: "",
      cartList: cartList,
      shippingAddress: user.shippingAddress!,
      orderDate: CommonUseCases.getCurrentDate(),
      customerName: user.name,
      orderTime: CommonUseCases.getCurrentTime(),
      orderStatus: "order_placed",
      orderPaymentMethod: "By Cash",
      cartOrderTotal: priceBreakup["cartTotal"],
      orderlastAmtAfterDiscount: priceBreakup["lastPriceAfterDiscount"]!,
      orderdiscountAmt: priceBreakup["discountAmt"]!,
      orderdiscountPercent: priceBreakup["discountPercent"]!,
    );
    await locator<OrderListRepo>().addOrderDetails(orderModel,context);
  }
}