import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/presentation/screens/cart_screen/bloc/cart_bloc.dart';
import 'package:rj/features/presentation/widgets/address_change_widget.dart';
import 'package:rj/features/presentation/widgets/button_green.dart';
import 'package:rj/features/services/show_loading_services.dart';
import 'package:rj/utils/constants.dart';

import '../../../../utils/styles.dart';
import '../../../../utils/text_controllers.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  LoadingServices loadingServices = LoadingServices();

  @override
  Widget build(BuildContext context) {
    cartQuantity.text = "1";
    context.read<CartBloc>().add(FetchCartEvent());
    return BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FetchCartSuccess) {
            int totals = 0;
            final totalPrice =
                state.cartList.map((e) => e.sellingPrize).toList();
            for (var i in totalPrice) {
              totals = totals + int.parse(i);
            }
            int lastAmt = totals - 120;
            String? selectedQval;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedH20,
                  Text(
                    "Shipping Address",
                    style: style(
                        color: Colors.black,
                        fontSize: 18,
                        weight: FontWeight.bold),
                  ),
                  sizedH20,
                  AddressChangeWidget(
                      callback: () => callback(), userModal: state.userModel),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            color: Colors.white,
                            child: Column(
                              children: [
                                _imageName(state, index),
                                sizedH10,
                                _quantityPriceSection(
                                    state.cartList[index].sellingPrize),
                                sizedH20,
                                const Row(
                                  children: [
                                    Text("Delivery by Aug 30, Wed"),
                                    sizedW30,
                                    Text(
                                      "30rs",
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough),
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
                      ),
                    ),
                  ),
                  state.cartList.isNotEmpty
                      ? _priceDetailsSection(state, totals, lastAmt)
                      : SizedBox()
                ],
              ),
            );
          }
          return SizedBox();
        });
  }

  Container _removeFromCartButton(
      BuildContext context, FetchCartSuccess state, int index) {
    return Container(
      decoration: BoxDecoration(),
      child: TextButton(
          onPressed: () {
            context
                .read<CartBloc>()
                .add(RemoveFromCartEvent(cartModel: state.cartList[index],context: context));
          },
          child: Text("Remove")),
    );
  }

  Column _priceDetailsSection(FetchCartSuccess state, int totals, int lastAmt) {
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
            Text("$rupeeSymbol  $totals"),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Discount",
              style: TextStyle(color: Colors.green),
            ),
            Text(
              "$rupeeSymbol -120",
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
        Center(
            child: ButtonGreen(
                backgroundColor: Colors.yellow,
                label: "Place Order",
                callback: callback,
                color: Colors.black))
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
          height: 70.0,
          width: 70.0,
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

  Row _quantityPriceSection(String sellingPrize) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 70,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: Colors.grey,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Qty: "),
              Flexible(
                child: TextField(
                  controller: cartQuantity,
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                  ),
                ),
              )
            ],
          ),
        ),
        sizedW20,
        Text(
          "$rupeeSymbol $sellingPrize",
          style:
              style(fontSize: 20, color: Colors.black, weight: FontWeight.bold),
        )
      ],
    );
  }

  callback() {}
}
