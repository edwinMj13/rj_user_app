import 'package:rj/features/data/models/cart_model.dart';

class OrderModel {
  final String userNodeId;
  final String orderNodeId;
  final String shippingAddress;
  final String customerName;
  final String orderTime;
  final String orderDate;
  final String orderStatus;
  final String orderPaymentMethod;
  final double cartOrderTotal;
  final double orderlastAmtAfterDiscount;
  final double orderdiscountAmt;
  final int orderdiscountPercent;
  String? orderNodeIdInUsers;
  final List<CartModel> cartList;

  OrderModel({
    required this.userNodeId,
    required this.orderNodeId,
    required this.cartList,
    required this.shippingAddress,
    required this.orderDate,
    required this.customerName,
    required this.orderTime,
    required this.orderStatus,
    required this.orderPaymentMethod,
    required this.cartOrderTotal,
    required this.orderlastAmtAfterDiscount,
    required this.orderdiscountAmt,
    required this.orderdiscountPercent,
    this.orderNodeIdInUsers,
  });

  Map<String, dynamic> toMap() {
    return {
      "userNodeId": userNodeId,
      "orderNodeId": orderNodeId,
      "shippingAddress": shippingAddress,
      "customerName": customerName,
      "orderTime": orderTime,
      "orderStatus": orderStatus,
      "orderPaymentMethod": orderPaymentMethod,
      "cartOrderTotal": cartOrderTotal,
      "orderlastAmtAfterDiscount": orderlastAmtAfterDiscount,
      "orderdiscountAmt": orderdiscountAmt,
      "orderdiscountPercent": orderdiscountPercent,
      "orderDate": orderDate,
      "orderNodeIdInUsers": orderNodeIdInUsers,
      "cartList": cartList.map((item)=>item.toMap()),
    };
  }
//
// factory  OrderModel.{
//   return OrderModel();
// }
}