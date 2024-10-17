import 'package:flutter/cupertino.dart';
import 'package:rj/config/routes/route_names.dart';
import 'package:rj/features/data/models/order_cart_purchase_model.dart';
import 'package:rj/features/data/repository/order_list_respository.dart';
import 'package:rj/features/domain/use_cases/cart_use_cases.dart';

import '../../../utils/dependencyLocation.dart';
import '../../data/models/cart_model.dart';
import '../../data/models/order_model.dart';
import '../../data/models/user_profile_model.dart';
import 'common_use_cases.dart';

class OrderListCases {
  static navigateToOrderDetailsScreen(
      BuildContext context, List<OrderCartPurchaseModel> purchaseCart,OrderModel orderModel,String invNo) {
    final priceBreakupMap = {
      "cartTotal": double.parse(orderModel.cartOrderTotal),
      "discountPercent": int.parse(orderModel.orderdiscountPercent),
      "lastPriceAfterDiscount":double.parse(orderModel.orderlastAmtAfterDiscount),
      "discountAmt": double.parse(orderModel.orderdiscountAmt),
      "tag": "ol",
    };
    Map<String,dynamic> map = {
      "priceBreakup":priceBreakupMap,
      "purchaseCart":purchaseCart,
      "invNo": invNo,
    };
    Navigator.pushNamed(context, RouteNames.orderDetailsScreen,
        arguments: map);
  }

  static addOrderDetails(List<CartModel> cartList, UserProfileModel user,
      Map<String, dynamic> priceBreakup, BuildContext context, String paymentId) async {
    List<OrderCartPurchaseModel> purchasedCartList= [];
    for(var item in cartList) {
      final itemDiscountAmt = CartUseCase.discountAmt(double.parse(item.sellingPrize), priceBreakup["discountPercent"]);
      final amtAfterDiscount = CartUseCase.getLastTotalAmount(double.parse(item.sellingPrize), itemDiscountAmt);
      purchasedCartList.add(OrderCartPurchaseModel(
        itemName: item.itemName,
        itemCategory: item.category,
        itemFirebaseNodeId: item.firebaseNodeId,
        itemMrp: item.itemMrp,
        itemProductId: item.productId,
        itemStatus: item.status,
        imagesList: item.imagesList,
        itemCartedQuantity: item.cartedQuantity.toString(),
        itemPrice: item.price,
        itemSubCategory: item.subCategory,
        itemCartedLastAmt: amtAfterDiscount.toStringAsFixed(2),
        itemDiscountAmt: itemDiscountAmt.toStringAsFixed(2),
        itemDiscountPercent: priceBreakup["discountPercent"]!.toString(),
        itemDescription: item.description,
        itemBrand: item.itemBrand,
        itemMainImage: item.mainImage,
        itemSellingPrize: item.sellingPrize,
      ));
    }
    final orderModel = OrderModel(
      userNodeId: user.nodeID,
      orderNodeId: "",
      purchasedCartList: purchasedCartList,
      shippingAddress: user.shippingAddress!,
      invoiceNo: "",
      paymentId: paymentId,
      orderDate: CommonUseCases.getCurrentDate(),
      customerName: user.name,
      orderTime: CommonUseCases.getCurrentTime(),
      orderStatus: "Order Placed",
      orderNodeIdInUsers: "",
      orderPaymentMethod: "By Cash",
      cartOrderTotal: priceBreakup["cartTotal"],
      orderlastAmtAfterDiscount: priceBreakup["lastPriceAfterDiscount"]!,
      orderdiscountAmt: priceBreakup["discountAmt"]!,
      orderdiscountPercent: priceBreakup["discountPercent"]!,
    );
    await locator<OrderListRepo>().addOrderDetails(orderModel, context);
  }
}
