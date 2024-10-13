import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/styles.dart';
import '../../data/models/products_model.dart';

class TextPriceSectionLineWidget extends StatelessWidget {
  const TextPriceSectionLineWidget({
    super.key,
    required this.price,
    required this.offerPrice,
  });

  final String price;
  final String offerPrice;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: "",
          //style: ,
          children:[
            TextSpan(
              text: "$rupeeSymbol ${price}",
              style: const TextStyle(color: Colors.black,decoration: TextDecoration.lineThrough,fontSize: 19),
            ),
            TextSpan(
              text: " $rupeeSymbol ${offerPrice}",
              style: style(fontSize: 25, color: Colors.green, weight: FontWeight.bold),
            ),
          ]
      ),
    );
  }
}
