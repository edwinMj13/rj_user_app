import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ShowLoadingCase{
  BuildContext? contextsProgress;
  void showLoading(BuildContext context, String label) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (contextProgressInner) {
          contextsProgress = contextProgressInner;
          return PopScope(
            canPop: false,
            child: Dialog(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    CircularProgressIndicator(),
                    sizedW20,
                    Text(
                      label,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
  cancelLoading(){
    Navigator.of(contextsProgress!).pop();
  }
}