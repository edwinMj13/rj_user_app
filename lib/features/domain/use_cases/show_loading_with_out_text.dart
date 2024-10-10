import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ShowLoadingWithOutCase{
  BuildContext? contextsProgress;
  void showLoadingWithout(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (contextProgressInner) {
          contextsProgress = contextProgressInner;
          return const PopScope(
            canPop: false,
            child: Center(child: CircularProgressIndicator(backgroundColor: Colors.white,)),
          );
        });
  }
  cancelLoading(){
    Navigator.of(contextsProgress!).pop();
  }
}