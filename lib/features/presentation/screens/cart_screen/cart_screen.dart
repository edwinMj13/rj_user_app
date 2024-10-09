import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/domain/use_cases/cart_use_cases.dart';
import 'package:rj/features/presentation/screens/cart_screen/bloc/cart_bloc.dart';
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
          if (state is FetchCartSuccess) {
            double cartTotal = CartUseCase.getCartTotal(state.cartList);
            double discountAmt = CartUseCase.discountAmt(cartTotal, 12);
            String lastPrice =
                CartUseCase.getLastTotalAmount(cartTotal, discountAmt).toStringAsFixed(2);

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        _cartItems(state, context),
                        sizedH20,
                        state.cartList.isNotEmpty
                            ? _priceDetailsSection(
                                state, cartTotal, lastPrice, discountAmt)
                            : const SizedBox(),
                        const SizedBox(height: 60,),
                      ],
                    ),
                  ),
                ),
                state.cartList.isNotEmpty ?Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  //top: 1,
                    child: _placeOrderButton(lastPrice),)
                    :SizedBox(),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
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
          Text("$rupeeSymbol $lastPrice",style: style(fontSize: 18, color: Colors.green, weight: FontWeight.bold),),
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
              _imageName(state, index),
              sizedH10,
              _quantityPriceSection(state.cartList[index], context),
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

  Column _priceDetailsSection(FetchCartSuccess state, double cartTotal,
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

  Row _imageName(FetchCartSuccess state, int index) {
    return Row(
      children: [
        Image.network(
          state.cartList[index].mainImage,
          height: 100.0,
          width: 100.0,
        ),
        sizedW20,
        Text(
          state.cartList[index].itemName,
          style:
              style(fontSize: 18, color: Colors.black, weight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _quantityPriceSection(CartModel productModel, BuildContext context) {
    CartUseCase cartUseCase = CartUseCase();
    return ValueListenableBuilder<int>(
        valueListenable: CartUseCase.valQuantityNotifier,
        builder: (context, snap, _) {
          return Row(
            children: [
              SizedBox(
                width: 100,
                child: Center(
                  child: DropdownMenu(
                    initialSelection: productModel.cartedQuantity,
                    width: 80,
                    // menuWidth: 50,
                    // disabledHint: const Text("Qty", style: TextStyle(fontSize: 11),),
                    // borderRadius: BorderRadius.circular(10.0),
                    label: const Text(
                      "Qty",
                      style: TextStyle(fontSize: 11),
                    ),
                    trailingIcon: const Icon(
                      Icons.arrow_drop_down,
                      size: 15,
                    ),
                    dropdownMenuEntries: [1, 2, 3, 4, 5]
                        .map(
                          (item) => DropdownMenuEntry(
                              value: item, label: item.toString()),
                        )
                        .toList(),
                    onSelected: (value) {
                      cartUseCase.updateQuantity(value!);
                      if (productModel.cartedQuantity != value) {
                        context.read<CartBloc>().add(CartUpdateEvent(
                            value: value,
                            cartModel: productModel,
                            context: context));
                      }
                    },
                  ),
                ),
              ),
              sizedW20,
              Text(
                "$rupeeSymbol ${productModel.totalAmount}",
                style: style(
                    fontSize: 20, color: Colors.black, weight: FontWeight.bold),
              )
            ],
          );
        });
  }

  callback() {}
}
