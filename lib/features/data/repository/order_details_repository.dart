import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/order_cart_purchase_model.dart';
import 'package:rj/features/data/models/order_model.dart';

import '../models/to_model_class.dart';

class OrderDetailsRepo {
  final firebase = FirebaseFirestore.instance;

  Future<OrderModel> getOrderDetails(String orderId, String userNode) async {
    List<OrderCartPurchaseModel> purchasedList = [];
    final data = await firebase
        .collection("Users")
        .doc(userNode)
        .collection("orders")
        .doc(orderId)
        .get();
    final model = data.data();
    print("Order Cart List ${model!["cartList"]}");
    //final cartList = model["cartList"];

    for(var item in model["cartList"]) {
      purchasedList.add(ToModelClass.toPurchaseModel(item));
    }
    print(purchasedList);
    final orderModel =  OrderModel(
      userNodeId: model["userNodeId"],
      orderNodeId: model["orderNodeId"],
      paymentId: model["paymentId"],
      purchasedCartList: purchasedList,
      invoiceNo: model["purchasedList"],
      shippingAddress: model["shippingAddress"],
      orderDate: model["orderDate"],
      customerName: model["customerName"],
      orderTime: model["orderTime"],
      orderStatus: model["orderStatus"],
      orderPaymentMethod: model["orderPaymentMethod"],
      cartOrderTotal: model["cartOrderTotal"],
      orderlastAmtAfterDiscount: model["orderlastAmtAfterDiscount"],
      orderdiscountAmt: model["orderdiscountAmt"],
      orderdiscountPercent: model["orderdiscountPercent"],
      orderNodeIdInUsers: model["orderNodeIdInUsers"],
    );
    return orderModel;
  }
}
