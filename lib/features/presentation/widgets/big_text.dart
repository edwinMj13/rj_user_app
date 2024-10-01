import 'package:flutter/material.dart';

import '../../../utils/styles.dart';

class BigTextLogin extends StatelessWidget {
  final String text;

  const BigTextLogin({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style(fontSize: 40, color: Colors.black, weight: FontWeight.bold),
    );
  }
}