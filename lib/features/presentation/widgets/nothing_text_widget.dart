import 'package:flutter/material.dart';

import '../../../utils/styles.dart';

class NothingTextWidget extends StatelessWidget {
  const NothingTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "There is Nothing Here",
      style: style(
          fontSize: 20,
          color: Colors.grey,
          weight: FontWeight.normal),
    );
  }
}
