import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/order_cart_purchase_model.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/domain/use_cases/common_use_cases.dart';
import 'package:rj/features/domain/use_cases/place_order_cases.dart';
import 'package:rj/features/presentation/screens/product_details/product_details_screen.dart';
import 'package:rj/features/presentation/widgets/text_price_section_line_widget.dart';

import '../../../../../../utils/constants.dart';
import '../../../../../../utils/styles.dart';
import '../../../widgets/hundred_h_w_image_widget.dart';

class OrderDetailsCartItemsWidget extends StatelessWidget {
  final PlaceOrderCases placeOrderCases = PlaceOrderCases();

  OrderDetailsCartItemsWidget({super.key, required this.purchaseModel});

  final List<OrderCartPurchaseModel> purchaseModel;

  @override
  Widget build(BuildContext context) {
    print("slodfigkjfkm ${purchaseModel}");
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(
        height: 0.5,
        color: Colors.black12,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            /*final model = ProductsModel(
              itemName: purchaseModel[index].itemName,
              category: purchaseModel[index].itemCategory,
              itemMrp: purchaseModel[index].itemMrp,
              firebaseNodeId: purchaseModel[index].firebaseNodeId,
              productId: purchaseModel[index].productId,
              status: purchaseModel[index].status,
              imagesList: purchaseModel[index].imagesList,
              description: purchaseModel[index].description,
              itemBrand: purchaseModel[index].itemBrand,
              mainImage: purchaseModel[index].mainImage,
              sellingPrize: purchaseModel[index].sellingPrize,
              totalMrp: purchaseModel[index].totalMrp,
              subCategory: purchaseModel[index].subCategory,
              price: purchaseModel[index].price,
              stock: purchaseModel[index].stock,
            );
            ProductDetailsScreen(productModel: model);
            placeOrderCases.navigateToProdDetails(context,cartList[index]);*/
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    HundredHWImageWidget(
                      mainImage: purchaseModel[index].itemMainImage,
                    ),
                    sizedW10,
                    Expanded(
                        child:
                            _namePriceSection(purchaseModel[index], context)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      itemCount: purchaseModel.length,
    );
  }

  Widget _namePriceSection(
      OrderCartPurchaseModel purchaseModel, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          purchaseModel.itemName,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style:
              style(fontSize: 18, color: Colors.black, weight: FontWeight.bold),
        ),
        Row(
          children: [
            Text(purchaseModel.itemCategory),
            sizedW10,
            Container(
              width: 10,
              height: 1,
              color: Colors.black,
            ),
            sizedW10,
            Text(purchaseModel.itemSubCategory!),
          ],
        ),
        Text(
          " $rupeeSymbol ${purchaseModel.itemCartedLastAmt.toString()}",
          style:
              style(fontSize: 25, color: Colors.green, weight: FontWeight.bold),
        ),
      ],
    );
  }
}
