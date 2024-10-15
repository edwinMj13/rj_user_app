import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/to_model_class.dart';

import '../../domain/use_cases/common_use_cases.dart';
import '../../presentation/screens/main_screen/bloc/main_bloc.dart';
import '../models/order_model.dart';

class OrderListRepo {
  final firebase = FirebaseFirestore.instance;

  addOrderDetails(OrderModel orderModel, BuildContext context) async {
    print("addOrderDetails   ${orderModel.userNodeId}");
    await firebase
        .collection("Orders")
        .add(orderModel.toMap())
        .then((node) async {
      final order = OrderModel(
        userNodeId: orderModel.userNodeId,
        orderNodeId: node.id,
        cartList: orderModel.cartList,
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
        addOrderToUser(order, context);
      });
    });
  }

  addOrderToUser(OrderModel orderModel, BuildContext context) async {
    print("addOrderDetails   ${orderModel.userNodeId}");
    await firebase
        .collection("Users")
        .doc(orderModel.userNodeId)
        .collection("orders")
        .add(orderModel.toMap())
        .then((node) async {
      orderModel.orderNodeIdInUsers = node.id;
      await firebase
          .collection("Users")
          .doc(orderModel.userNodeId)
          .collection("orders")
          .doc(node.id)
          .update(orderModel.toMap())
          .then((_) {
        Future.delayed(Duration(seconds: 1));
        context.read<MainBloc>().add(UpdateIndexCarBadgeEvent(index: 0));
        CommonUseCases.gotoHomeScreen(context);
      });
    });
  }

  Future<List<OrderModel?>> getOrderList(String userNodeId) async {
    List<CartModel> cartList = [];
    OrderModel? orderModel;
    final data = await firebase
        .collection("Users")
        .doc(userNodeId)
        .collection("orders")
        .get();
    final dataMap = data.docs;
    List<OrderModel?> orderList = dataMap.map((model) {
      print("Started");
      cartList.clear();
      for (var item in model["cartList"]) {
        cartList.add(ToModelClass.toCartModel(item));
        orderModel = OrderModel(
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
        print(cartList.length);
      }
      return orderModel;
    }).toList();
    print("Finished All");
    return orderList;
  }
}
