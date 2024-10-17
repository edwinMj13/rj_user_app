import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/order_cart_purchase_model.dart';
import 'package:rj/features/data/models/to_model_class.dart';
import 'package:rj/features/data/repository/cart_repository.dart';
import 'package:rj/utils/dependencyLocation.dart';

import '../../domain/use_cases/common_use_cases.dart';
import '../../presentation/screens/main_screen/bloc/main_bloc.dart';
import '../models/order_model.dart';

class OrderListRepo {
  final firebase = FirebaseFirestore.instance;

  addOrderDetails(OrderModel orderModel, BuildContext context) async {
    print("addOrderDetails   ${orderModel.userNodeId}");
    String? invNo ;
    await firebase
        .collection("Orders")
        .add(orderModel.toMap())
        .then((node) async {
          
      final order = OrderModel(
        userNodeId: orderModel.userNodeId,
        orderNodeId: node.id,
        invoiceNo: orderModel.paymentId.substring(orderModel.paymentId.length-6),
        paymentId: orderModel.paymentId,
        purchasedCartList: orderModel.purchasedCartList,
        orderNodeIdInUsers: "",
        shippingAddress: orderModel.shippingAddress,
        orderDate: orderModel.orderDate,
        customerName: orderModel.customerName,
        orderTime: orderModel.orderTime,
        orderStatus: orderModel.orderStatus,
        orderPaymentMethod: orderModel.orderPaymentMethod,
        cartOrderTotal: orderModel.cartOrderTotal,
        orderlastAmtAfterDiscount: orderModel.orderlastAmtAfterDiscount,
        orderdiscountAmt: orderModel.orderdiscountAmt,
        orderdiscountPercent: orderModel.orderdiscountPercent,
      );
      await firebase
          .collection("Orders")
          .doc(node.id)
          .update(order.toMap())
          .then((_) {
        addOrderToUser(order, context,node.id);
      });
    });
  }

  addOrderToUser(OrderModel orderModel, BuildContext context, String id) async {
    print("addOrderDetails   ${orderModel.userNodeId}");
    await firebase
        .collection("Users")
        .doc(orderModel.userNodeId)
        .collection("orders")
        .doc(id)
        .set(orderModel.toMap())
        .then((node) async {
      orderModel.orderNodeIdInUsers = id;
        Future.delayed(Duration(seconds: 1));
        locator<CartRepository>().clearCart(orderModel.userNodeId);
        context.read<MainBloc>().add(UpdateIndexCarBadgeEvent(index: 0));
        CommonUseCases.gotoHomeScreen(context);
    });
  }

  Future<List<OrderModel?>> getOrderList(String userNodeId) async {
    OrderModel? orderModel;
    final data = await firebase
        .collection("Users")
        .doc(userNodeId)
        .collection("orders")
        .get();
    final dataMap = data.docs;
    List<OrderModel?> orderList = dataMap.map((model) {
      List<OrderCartPurchaseModel> cartList = [];
      print("Started");
      for (var item in model["purchasedCartList"]) {
        cartList.add(ToModelClass.toPurchaseModel(item));
      }
        orderModel = OrderModel(
          userNodeId: model["userNodeId"],
          orderNodeId: model["orderNodeId"],
          invoiceNo: model["invoiceNo"],
          paymentId: model["paymentId"],
          purchasedCartList: cartList,
          shippingAddress: model["shippingAddress"],
          orderDate: model["orderDate"],
          customerName: model["customerName"],
          orderTime: model["orderTime"],
          orderStatus: model["orderStatus"],
          orderPaymentMethod: model["orderPaymentMethod"],
          cartOrderTotal: model["cartOrderTotal"].toString(),
          orderlastAmtAfterDiscount: model["orderlastAmtAfterDiscount"].toString(),
          orderdiscountAmt: model["orderdiscountAmt"].toString(),
          orderdiscountPercent: model["orderdiscountPercent"].toString(),
          orderNodeIdInUsers: model["orderNodeIdInUsers"],
        );
        print(cartList.length);
      return orderModel;
    }).toList();
    print("Finished All");
    return orderList;
  }
}
