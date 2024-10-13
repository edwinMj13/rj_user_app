import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/domain/use_cases/common_use_cases.dart';
import 'package:rj/features/presentation/widgets/text_price_section_line_widget.dart';

import '../../../../../utils/constants.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/text_controllers.dart';
import '../../../../data/models/cart_model.dart';
import '../../../../domain/use_cases/cart_use_cases.dart';
import '../bloc/cart_bloc.dart';

class CartItemsListWidget extends StatelessWidget {
  final FetchCartSuccessState state;
  const CartItemsListWidget({super.key,required this.state});

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
                  _imageQty(state, index, state.cartList[index],context),
                  sizedW10,
                  Expanded(child: _namePriceSection(state.cartList[index], context)),
                ],
              ),
              sizedH20,
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
              _removeFromCartButton(context, state, index)
            ],
          ),
        );
      },
      itemCount: state.cartList.length,
    );
  }
  Column _imageQty(FetchCartSuccessState state, int index, CartModel productModel, BuildContext context) {
    final listDialog = ["1", "2", "3", "4", "5", "more"];
    return Column(
      children: [
        Image.network(
          state.cartList[index].mainImage,
          height: 100.0,
          width: 100.0,
          loadingBuilder: (context,child,loadingProgress)=>CommonUseCases.checkIfImageLoadingPRODUCTPlaceholder(loadingProgress, child,100),
        ),
        sizedH10,
        InkWell(
          onTap: () {
            _quantityRawDataShowDialog(context, listDialog, productModel);
          },
          child: Container(
            width: 70,
            height: 40,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 0.5,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Qty : ",
                  style: style(
                      fontSize: 12,
                      color: Colors.black,
                      weight: FontWeight.normal),
                ),
                Text(productModel.cartedQuantity.toString()),
              ],
            ),
          ),
        ),

        // Text(
        //   state.cartList[index].itemName,
        //   style:
        //       style(fontSize: 18, color: Colors.black, weight: FontWeight.bold),
        // ),
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

  Future<dynamic> _quantityRawDataShowDialog(BuildContext contextMain,
      List<String> listDialog, CartModel productModel) {
    return showDialog(
      context: contextMain,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 5.0),
                 child: Text("Select Quantity",style:style(
                    fontSize: 20,
                    color: Colors.black,
                    weight: FontWeight.normal)),
               ),
              Container(
                height: 0.5,
                decoration: const BoxDecoration(
                  color: Colors.grey,

                ),
              ),
              ...List.generate(listDialog.length, (index) {
              return InkWell(
                onTap: () {
                  if (listDialog[index] != "more") {
                    CartUseCase.changeQuantity(
                        productModel, listDialog, index, context);
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return _enterMoreQuantity(context, productModel);
                        });
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      listDialog[index],
                      style: style(
                          fontSize: 15,
                          color: Colors.black,
                          weight: FontWeight.normal),
                    ),
                  ),
                ),
              );
            }).toList(),],
          ),
        );
      },
    );
  }

  Container _removeFromCartButton(
      BuildContext context, FetchCartSuccessState state, int index) {
    return Container(
      decoration: BoxDecoration(),
      child: TextButton(
          onPressed: () {
            context.read<CartBloc>().add(RemoveFromCartEvent(
                cartModel: state.cartList[index], context: context));
          },
          child: Text("Remove")),
    );
  }


  Widget _enterMoreQuantity(BuildContext context, CartModel productModel) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Enter Quantity"),
          TextField(
            controller: addExtraQuantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: "Quantity"),
          ),
        ],
      ),
      actionsPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(10),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              if (productModel.cartedQuantity.toString() !=
                  addExtraQuantityController.text) {
                context.read<CartBloc>().add(CartUpdateEvent(
                    value: int.parse(addExtraQuantityController.text),
                    cartModel: productModel,
                    context: context));
              }
              Navigator.of(context).pop();
              addExtraQuantityController.clear();
            },
            child: Text("Ok")),
      ],
    );
  }
}
