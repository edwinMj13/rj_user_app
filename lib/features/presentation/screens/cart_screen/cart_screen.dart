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
import 'package:rj/features/presentation/widgets/price_summary_widget.dart';
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
  final cartCases = CartUseCase();

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
            int discountPercent = 12;
            double discountAmt =
                CartUseCase.discountAmt(cartTotal, discountPercent);
            String lastPriceAfterDiscount =
                CartUseCase.getLastTotalAmount(cartTotal, discountAmt)
                    .toStringAsFixed(2);

            return Stack(
              fit: StackFit.expand,
              children: [
                _cartListAndDetails(state, context, cartTotal,
                    lastPriceAfterDiscount, discountAmt, discountPercent),
                _placeOrderButton(
                    state, lastPriceAfterDiscount, discountPercent),
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
      String lastPriceAfterDiscount,
      double discountAmt,
      int discountPercent) {
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
                ? PriceSummaryWidget(
                    length: state.cartList.length,
                    cartTotal: cartTotal,
                    lastAmtAfterDiscount: double.parse(lastPriceAfterDiscount),
                    discountAmt: discountAmt,
                    discountPercent: discountPercent,
                  )
                : const SizedBox(),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeOrderButton(FetchCartSuccessState state,
      String lastPriceAfterDiscount, int discountPercent) {
    return state.cartList.isNotEmpty
        ? Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 65,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$rupeeSymbol $lastPriceAfterDiscount",
                    style: style(
                        fontSize: 18,
                        color: Colors.green,
                        weight: FontWeight.bold),
                  ),
                  ButtonGreen(
                      backgroundColor: Colors.yellow,
                      label: "Place Order",
                      callback: () => CartUseCase.passDetailsToPlaceOrderScreen(
                          context,
                          state.cartList,
                          state.userModel,
                          lastPriceAfterDiscount),
                      buttonHeight: const Size.fromHeight(45),
                      color: Colors.black),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
