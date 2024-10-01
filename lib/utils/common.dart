


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

snackbar(BuildContext context, String s){
  ScaffoldMessenger.of(context)
      .showSnackBar( SnackBar(content: Text(s)));
}