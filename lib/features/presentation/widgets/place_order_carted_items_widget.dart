import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/domain/use_cases/common_use_cases.dart';
import 'package:rj/features/presentation/widgets/text_price_section_line_widget.dart';

import '../../../../../utils/constants.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/text_controllers.dart';
import '../../data/models/cart_model.dart';
import '../../domain/use_cases/cart_use_cases.dart';
import '../screens/cart_screen/bloc/cart_bloc.dart';

class PlaceOrderCartedItemsWidget extends StatelessWidget {
  final List<CartModel> cartList;
  const PlaceOrderCartedItemsWidget({super.key,required this.cartList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(
        height: 0.5,
        color: Colors.black12,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  _image(cartList[index],context),
                  sizedW10,
                  Expanded(child: _namePriceSection(cartList[index], context)),
                ],
              ),
             /* sizedH20,
              const Row(
                children: [
                  Text("Delivery by Aug 30, Wed"),
                  sizedW30,
                  Text(
                    "30rs",
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                  sizedW10,
                  Text(
                    "FREE",
                    style: TextStyle(color: Colors.green),
                  )
                ],
              ),
              _removeFromCartButton(context, cartList[index])*/
            ],
          ),
        );
      },
      itemCount: cartList.length,
    );
  }
  Column _image( CartModel cartModel, BuildContext context) {
   // final listDialog = ["1", "2", "3", "4", "5", "more"];
    return Column(
      children: [
        Image.network(
          cartModel.mainImage,
          height: 100.0,
          width: 100.0,
          loadingBuilder: (context,child,loadingProgress)=>CommonUseCases.checkIfImageLoadingPRODUCTPlaceholder(loadingProgress, child,100),
        ),
        sizedH10,
      ],
    );
  }

  Widget _namePriceSection(CartModel productModel, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // InkWell(
        //   onTap: () {
        //     _quantityRawDataShowDialog(context, listDialog, productModel);
        //   },
        //   child: Container(
        //     width: 70,
        //     height: 40,
        //     padding: const EdgeInsets.all(5.0),
        //     decoration: BoxDecoration(
        //         border: Border.all(
        //       color: Colors.grey,
        //       width: 0.5,
        //     )),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Text(
        //           "Qty : ",
        //           style: style(
        //               fontSize: 12,
        //               color: Colors.black,
        //               weight: FontWeight.normal),
        //         ),
        //         Text(productModel.cartedQuantity.toString()),
        //       ],
        //     ),
        //   ),
        // ),
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
            Container(width: 10,height: 1,color: Colors.black,),
            sizedW10,
            Text(productModel.subCategory!),
          ],
        ),
        TextPriceSectionLineWidget(price: productModel.price!, offerPrice: productModel.totalAmount.toString())
      ],
    );
  }

}
