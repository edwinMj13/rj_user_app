import 'package:flutter/material.dart';
import 'package:rj/utils/constants.dart';
import 'package:rj/utils/styles.dart';

class IconTextIconWidgets extends StatelessWidget {
  final IconData iconStart;
  final String label;
  const IconTextIconWidgets({
    super.key,
    required this.iconStart,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(iconStart,size: 30,),
                sizedW20,
                Text(label,style: style(fontSize: 17, color: Colors.black, weight: FontWeight.bold),),
              ],
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
