import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/domain/use_cases/cart_use_cases.dart';
import 'package:rj/features/presentation/screens/cart_screen/bloc/cart_bloc.dart';
import 'package:rj/features/presentation/screens/cart_screen/widgets/cart_items_list_widget.dart';
import 'package:rj/features/presentation/screens/cart_screen/widgets/empty_cart_widget.dart';
import 'package:rj/features/presentation/widgets/address_change_widget.dart';
import 'package:rj/features/presentation/widgets/button_green.dart';
import 'package:rj/utils/constants.dart';

import '../../../../utils/styles.dart';
import '../../../../utils/text_controllers.dart';
import '../../../domain/use_cases/show_loading_case.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<CartBloc>().add(FetchCartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          print("State Cart Screen ${state.runtimeType}");
          if (state is FetchCartSuccessState) {
            double cartTotal = CartUseCase.getCartTotal(state.cartList);
            double discountAmt = CartUseCase.discountAmt(cartTotal, 12);
            String lastPrice =
                CartUseCase.getLastTotalAmount(cartTotal, discountAmt)
                    .toStringAsFixed(2);

            return Stack(
              children: [
                _cartListAndDetails(
                    state, context, cartTotal, lastPrice, discountAmt),
                state.cartList.isNotEmpty
                    ? Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: _placeOrderButton(lastPrice),
                      )
                    : const SizedBox(),
              ],
            );
          } else if (state is FetchCartNullState) {
            return const EmptyCartWidget();
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  SingleChildScrollView _cartListAndDetails(
      FetchCartSuccessState state,
      BuildContext context,
      double cartTotal,
      String lastPrice,
      double discountAmt) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CartItemsListWidget(
              state: state,
            ),
            sizedH20,
            state.cartList.isNotEmpty
                ? _priceDetailsSection(state, cartTotal, lastPrice, discountAmt)
                : const SizedBox(),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeOrderButton(String lastPrice) {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$rupeeSymbol $lastPrice",
            style: style(
                fontSize: 18, color: Colors.green, weight: FontWeight.bold),
          ),
          ButtonGreen(
              backgroundColor: Colors.yellow,
              label: "Place Order",
              callback: callback,
              buttonHeight: Size.fromHeight(45),
              color: Colors.black),
        ],
      ),
    );
  }

  Column _priceDetailsSection(FetchCartSuccessState state, double cartTotal,
      String lastAmt, double discountAmt) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Price Details",
            style: style(
                fontSize: 20, color: Colors.black, weight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Price (${state.cartList.length}items)"),
            Text("$rupeeSymbol  $cartTotal"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Discount ( 12% )",
              style: TextStyle(color: Colors.green),
            ),
            Text(
              "$rupeeSymbol ${discountAmt.toString()}",
              style: TextStyle(color: Colors.green),
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
        _dottedLine(),
        sizedH10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Amount",
              style: style(
                  fontSize: 20, color: Colors.black, weight: FontWeight.bold),
            ),
            Text("$rupeeSymbol $lastAmt",
                style: style(
                    fontSize: 20,
                    color: Colors.black,
                    weight: FontWeight.bold)),
          ],
        ),
        sizedH10,
        _dottedLine(),
        sizedH10,
        Center(
            child: Text("You’ll save 120 rs on this order",
                style: style(
                    fontSize: 15,
                    color: Colors.green,
                    weight: FontWeight.bold))),
        sizedH10,
      ],
    );
  }

  DottedLine _dottedLine() {
    return const DottedLine(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 4.0,
      dashColor: Colors.black,
      //dashGradient: [Colors.red, Colors.blue],
      dashRadius: 0.0,
      dashGapLength: 4.0,
      dashGapColor: Colors.transparent,
      //dashGapGradient: [Colors.red, Colors.blue],
      dashGapRadius: 0.0,
    );
  }

/*
  ListView _cartItems(FetchCartSuccess state, BuildContext context) {
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
                  _imageQty(state, index, state.cartList[index]),
                  sizedW10,
                  _namePriceSection(state.cartList[index], context),
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

  Container _removeFromCartButton(
      BuildContext context, FetchCartSuccess state, int index) {
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


  Column _imageQty(FetchCartSuccess state, int index, CartModel productModel) {
    final listDialog = ["1", "2", "3", "4", "5", "more"];
    return Column(
      children: [
        Image.network(
          state.cartList[index].mainImage,
          height: 100.0,
          width: 100.0,
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
          style:
              style(fontSize: 18, color: Colors.black, weight: FontWeight.bold),
        ),
        sizedW20,
        Text(
          "$rupeeSymbol ${productModel.totalAmount}",
          style:
              style(fontSize: 20, color: Colors.black, weight: FontWeight.bold),
        )
      ],
    );
  }

  Future<dynamic> _quantityRawDataShowDialog(BuildContext contextMain,
      List<String> listDialog, CartModel productModel) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(listDialog.length, (index) {
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
            }).toList(),
          ),
        );
      },
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
      contentPadding: EdgeInsets.all(10),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel")),
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
*/
  callback() {}
}

