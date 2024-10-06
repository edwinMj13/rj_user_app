import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/styles.dart';
class ButtonGreen extends StatelessWidget {
  final String label;
  final VoidCallback callback;
  final Color color;
  final Color? backgroundColor;
  Size buttonHeight;

   ButtonGreen({this.buttonHeight=defaultButtonHeight,super.key,required this.backgroundColor, required this.label, required this.callback,required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        callback();
      },
      style: _buttonStyle(),
      child: Text(label,style: TextStyle(color: color),),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      fixedSize: buttonHeight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      side: const BorderSide(
        width: 1,
        color: Colors.green,
      ),
    );
  }
}
