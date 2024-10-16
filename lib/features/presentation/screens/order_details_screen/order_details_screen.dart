import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/order_cart_purchase_model.dart';
import 'package:rj/features/data/models/order_model.dart';
import 'package:rj/features/presentation/screens/order_details_screen/bloc/order_details_bloc.dart';
import 'package:rj/features/presentation/screens/order_details_screen/widgets/order_details_cart_items_widget.dart';
import 'package:rj/features/presentation/screens/order_list_screen/bloc/order_list_bloc.dart';
import 'package:rj/features/presentation/widgets/price_summary_widget.dart';

import '../../../data/models/to_model_class.dart';
import '../../widgets/place_order_carted_items_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
   OrderDetailsScreen({
    super.key,
    required this.purchasedCartList,
    required this.priceBreakup,
  });

  final List<OrderCartPurchaseModel> purchasedCartList;
  final Map<String,dynamic> priceBreakup;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            OrderDetailsCartItemsWidget(
                purchaseModel: purchasedCartList),
            PriceSummaryWidget(length: purchasedCartList.length, priceMap: priceBreakup)
          ],
        ),
      ))

    );
  }
}
