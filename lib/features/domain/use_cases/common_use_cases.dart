import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rj/features/data/models/order_model.dart';
import 'package:rj/utils/styles.dart';

import '../../../config/routes/route_names.dart';
import '../../presentation/screens/home_screen/bloc/home_bloc.dart';

class CommonUseCases {

  static Widget checkIfImageLoadingCATEGORYPlaceholder(ImageChunkEvent? loadingProgress, Widget child) {
    if(loadingProgress == null) return child;
    return const Icon(Icons.category);
  }
  static Widget checkIfImageLoadingPRODUCTPlaceholder(ImageChunkEvent? loadingProgress, Widget child, double size) {
    if(loadingProgress == null) return child;
    return Icon(CupertinoIcons.cube,size: size,color: Colors.grey,);
  }
  static gotoHomeScreen(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      context.read<HomeBloc>().add(FetchDataHomeEvent());
      Navigator.pushNamed(context, RouteNames.mainScreen);
    });
  }
  static String getCurrentDate(){
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy').format(now);
    return formattedDate;
  }
  static String getCurrentTime(){
    DateTime now = DateTime.now();
    return "${now.hour}:${now.minute}";
  }

  static Widget getStatus(OrderModel orderModel){
    if(orderModel.orderStatus =="order_placed"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order Placed",style: style(fontSize: 15, color: Colors.blue, weight: FontWeight.w700),),
          Text("Delivery on ${orderModel.orderDate}",style: style(fontSize: 12, color: Colors.grey, weight: FontWeight.normal),),
        ],
      );
    }else if(orderModel.orderStatus =="order_shipped"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order Shipped",style: style(fontSize: 15, color: Colors.greenAccent, weight: FontWeight.w700),),
          Text("Delivery on ${orderModel.orderDate}",style: style(fontSize: 12, color: Colors.grey, weight: FontWeight.normal),),

        ],
      );
    }else if(orderModel.orderStatus =="order_delivered"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order Delivered",style: style(fontSize: 15, color: Colors.green, weight: FontWeight.w700),),

        ],
      );
    }
    return Text("Pending",style: style(fontSize: 15, color: Colors.black, weight: FontWeight.w700),);
  }
}