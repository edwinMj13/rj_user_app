


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

snackbar(BuildContext context, String s){
  ScaffoldMessenger.of(context)
      .showSnackBar( SnackBar(content: Text(s)));
}

ValueNotifier<Map<String,dynamic>> sliderNotifier = ValueNotifier({});

updateSlider(double start,double end){
  Map<String,dynamic> data = {"start":start,"end":end,};
  sliderNotifier.value=data;
}