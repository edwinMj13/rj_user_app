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
            child: Dialog(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: CircularProgressIndicator(),
              ),
            ),
          );
        });
  }
  cancelLoading(){
    Navigator.of(contextsProgress!).pop();
  }
}