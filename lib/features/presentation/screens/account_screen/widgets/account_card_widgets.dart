import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rj/config/colors.dart';
import 'package:rj/utils/constants.dart';

class AccountCardWidgets extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Color color;
  const AccountCardWidgets({super.key,required this.iconData,required this.label,required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 140,
      decoration: BoxDecoration(
        color: color,borderRadius: BorderRadius.circular(10.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData,color: Colors.white,size: 30,),
          sizedH10,
          Text(label,style: const TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}
