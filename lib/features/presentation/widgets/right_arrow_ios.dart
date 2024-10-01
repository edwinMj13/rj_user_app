import 'package:flutter/material.dart';

class RightArrowIOS extends StatelessWidget {
  final VoidCallback pressFunction;
  const RightArrowIOS({
    super.key,
    required this.pressFunction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>pressFunction(),
      child: Container(
        height: 50,
        width: 50,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white70,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 1,
                  blurRadius: 5
              )
            ]
        ),
        child: Icon(
          Icons.arrow_forward_ios,
          size: 20,
        ),
      ),
    );
  }
}
