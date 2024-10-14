import 'package:flutter/material.dart';
import 'package:rj/features/presentation/widgets/dotted_line_widget.dart';

import '../../../utils/constants.dart';
import '../../../utils/styles.dart';

class PriceSummaryWidget extends StatelessWidget {
  const PriceSummaryWidget({super.key, required this.length, required this.priceMap});
  final int length;
  final Map<String, dynamic> priceMap;

  @override
  Widget build(BuildContext context) {
    final double cartTotal=priceMap["cartTotal"];
    final double lastAmtAfterDiscount=priceMap["lastPriceAfterDiscount"];
    final double discountAmt=priceMap["discountAmt"];
    final int discountPercent=priceMap["discountPercent"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Price Details",
            style: style(
                fontSize: 20, color: Colors.black, weight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Price (${length} items)"),
            Text("$rupeeSymbol  $cartTotal"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Discount ( ${discountPercent.toString()}% )",
              style: const TextStyle(color: Colors.green),
            ),
            Text(
              "$rupeeSymbol ${discountAmt.toString()}",
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Delivery Charges"),
            Text("FREE Delivery"),
          ],
        ),
        sizedH10,
        const DottedLineWidget(),
        sizedH10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Amount",
              style: style(
                  fontSize: 20, color: Colors.black, weight: FontWeight.bold),
            ),
            Text("$rupeeSymbol $lastAmtAfterDiscount",
                style: style(
                    fontSize: 20,
                    color: Colors.black,
                    weight: FontWeight.bold)),
          ],
        ),
        sizedH10,
        const DottedLineWidget(),
        sizedH10,
        Center(
            child: RichText(
              text: TextSpan(
                  text: "You’ll save ",
                  style: style(
                      fontSize: 15, color: Colors.green, weight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: "  $rupeeSymbol $discountAmt  ",
                        style: style(
                            fontSize: 20,
                            color: Colors.green,
                            weight: FontWeight.bold)),
                    TextSpan(
                        text: " on this order",
                        style: style(
                            fontSize: 15,
                            color: Colors.green,
                            weight: FontWeight.bold)),
                  ]),
            )),
        sizedH10,
      ],
    );
  }
}
