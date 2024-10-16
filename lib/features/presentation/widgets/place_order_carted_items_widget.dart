import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/domain/use_cases/common_use_cases.dart';
import 'package:rj/features/domain/use_cases/place_order_cases.dart';
import 'package:rj/features/presentation/screens/product_details/product_details_screen.dart';
import 'package:rj/features/presentation/widgets/text_price_section_line_widget.dart';

import '../../../../../utils/constants.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/text_controllers.dart';
import '../../data/models/cart_model.dart';
import '../../domain/use_cases/cart_use_cases.dart';
import '../screens/cart_screen/bloc/cart_bloc.dart';
import 'hundred_h_w_image_widget.dart';

class PlaceOrderCartedItemsWidget extends StatelessWidget {
  final List<CartModel> cartList;
  final PlaceOrderCases placeOrderCases = PlaceOrderCases();
  PlaceOrderCartedItemsWidget({super.key, required this.cartList});

  @override
  Widget build(BuildContext context) {
    print("slodfigkjfkm ${cartList}");
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
              itemName: cartList[index].itemName,
              category: cartList[index].category,
              itemMrp: cartList[index].itemMrp,
              firebaseNodeId: cartList[index].firebaseNodeId,
              productId: cartList[index].productId,
              status: cartList[index].status,
              imagesList: cartList[index].imagesList,
              description: cartList[index].description,
              itemBrand: cartList[index].itemBrand,
              mainImage: cartList[index].mainImage,
              sellingPrize: cartList[index].sellingPrize,
              totalMrp: cartList[index].totalMrp,
              subCategory: cartList[index].subCategory,
              price: cartList[index].price,
              stock: cartList[index].stock,
            );
            ProductDetailsScreen(productModel: model);*/
            placeOrderCases.navigateToProdDetails(context,cartList[index]);
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                HundredHWImageWidget(mainImage: cartList[index].mainImage,),
                    sizedW10,
                    Expanded(
                        child: _namePriceSection(cartList[index], context)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      itemCount: cartList.length,
    );
  }

  Widget _namePriceSection(CartModel productModel, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productModel.itemName,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style:
              style(fontSize: 18, color: Colors.black, weight: FontWeight.bold),
        ),
        Row(
          children: [
            Text(productModel.category),
            sizedW10,
            Container(
              width: 10,
              height: 1,
              color: Colors.black,
            ),
            sizedW10,
            Text(productModel.subCategory!),
          ],
        ),
        TextPriceSectionLineWidget(
            price: productModel.totalMrp,
            offerPrice: productModel.totalAmount.toString())
      ],
    );
  }
}


