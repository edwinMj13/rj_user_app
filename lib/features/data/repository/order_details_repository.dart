import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/order_model.dart';

import '../models/to_model_class.dart';

class OrderDetailsRepo {
  final firebase = FirebaseFirestore.instance;

  Future<OrderModel> getOrderDetails(String orderId, String userNode) async {
    List<CartModel> cartList = [];
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
      cartList.add(ToModelClass.toCartModel(item));
    }
    print(cartList);
    final orderModel =  OrderModel(
      userNodeId: model["userNodeId"],
      orderNodeId: model["orderNodeId"],
      cartList: cartList,
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
