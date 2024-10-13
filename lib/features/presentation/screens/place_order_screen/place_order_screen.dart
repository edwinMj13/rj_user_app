import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/domain/use_cases/place_order_cases.dart';
import 'package:rj/features/presentation/screens/place_order_screen/bloc/place_order_bloc.dart';
import 'package:rj/features/presentation/widgets/address_change_widget.dart';
import 'package:rj/utils/common.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/styles.dart';
import '../../../domain/use_cases/cart_use_cases.dart';
import '../../widgets/button_green.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({
    super.key,
    required this.cartList,
    required this.user,
    required this.lastPrice,
  });

  final List<CartModel> cartList;
  final UserProfileModel user;
  final String lastPrice;

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  late Razorpay razorPay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorPay = Razorpay();
    razorPay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS, PlaceOrderCases.onSuccessHandler);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, PlaceOrderCases.onErrorHandler);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorPay.clear();
  }

  @override
  Widget build(BuildContext context) {
    print("Place Order Screen ${widget.user.name}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary"),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    AddressChangeWidget(
                        callback: () => PlaceOrderCases.navigateToAddressChangeScreen(
                            context, widget.user),
                        userModal: widget.user),
                    const SizedBox(),
                  ],
                ),
              ),
              Positioned(
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
                        "$rupeeSymbol ${widget.lastPrice}",
                        style: style(
                            fontSize: 18,
                            color: Colors.green,
                            weight: FontWeight.bold),
                      ),
                      ButtonGreen(
                          backgroundColor: Colors.yellow,
                          label: "Place Order",
                          callback: () {
                            double q = double.parse(widget.lastPrice);
                            context.read<PlaceOrderBloc>().add(DoPaymentEvent(
                                razorpay: razorPay,
                                amount: q));
                          },
                          buttonHeight: const Size.fromHeight(45),
                          color: Colors.black),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
