import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
}