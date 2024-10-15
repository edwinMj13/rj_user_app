import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/order_model.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/domain/use_cases/common_use_cases.dart';
import 'package:rj/features/domain/use_cases/place_order_cases.dart';
import 'package:rj/features/domain/use_cases/show_loading_case.dart';
import 'package:rj/features/domain/use_cases/show_loading_with_out_text.dart';
import 'package:rj/features/presentation/screens/cart_screen/widgets/cart_items_list_widget.dart';
import 'package:rj/features/presentation/screens/place_order_screen/address_bloc/address_bloc.dart';
import 'package:rj/features/presentation/screens/place_order_screen/bloc/place_order_bloc.dart';
import 'package:rj/features/presentation/widgets/address_change_widget.dart';
import 'package:rj/features/presentation/widgets/price_summary_widget.dart';
import 'package:rj/utils/common.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/styles.dart';
import '../../../domain/use_cases/cart_use_cases.dart';
import '../../widgets/button_green.dart';
import '../../widgets/place_order_carted_items_widget.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({
    super.key,
    required this.cartList,
    required this.user,
    required this.priceBreakup,
  });

  final List<CartModel> cartList;
  final UserProfileModel user;
  final Map<String, dynamic> priceBreakup;

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  late Razorpay razorPay;
  double? cartTotal;
  double? lastAmtAfterDiscount;
  double? discountAmt;
  int? discountPercent;
  late BuildContext successContext, failureContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartTotal = widget.priceBreakup["cartTotal"];
    lastAmtAfterDiscount = widget.priceBreakup["lastPriceAfterDiscount"];
    discountAmt = widget.priceBreakup["discountAmt"];
    discountPercent = widget.priceBreakup["discountPercent"];
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccessHandler);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, onErrorHandler);
  }

  onSuccessHandler(PaymentSuccessResponse response) {
    print("\n\n\n\n\n\nPayment SuccessFull \n"
        "${response.data}\n\n\n\n\n\n");

    PlaceOrderCases.navigateToSuccessPage(
        context, response,widget.user.nodeID, widget.priceBreakup, widget.cartList);
  }

  onErrorHandler(PaymentFailureResponse response) {
    print("${response.error}");
    showDialog(
        context: context,
        builder: (context) {
          return const Dialog(
            backgroundColor: Colors.red,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                sizedH20,
                Text(
                  "Payment Failed",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        });
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
              _addressCartPriceBreakUp(),
              _rateProceedButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _rateProceedButton(BuildContext context) {
    return Positioned(
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
              "$rupeeSymbol $lastAmtAfterDiscount",
              style: style(
                  fontSize: 18, color: Colors.green, weight: FontWeight.bold),
            ),
            ButtonGreen(
                backgroundColor: Colors.yellow,
                label: "Proceed",
                callback: () {
                  int q = lastAmtAfterDiscount!.toInt();
                  context
                      .read<PlaceOrderBloc>()
                      .add(DoPaymentEvent(razorpay: razorPay, amount: q));
                },
                buttonHeight: const Size.fromHeight(45),
                color: Colors.black),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _addressCartPriceBreakUp() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _addressSection(),
          sizedH10,
          Container(
            height: 0.5,
            color: Colors.grey,
          ),
          sizedH10,
          _cartPriceSection(),
          const SizedBox(),
        ],
      ),
    );
  }

  BlocBuilder<PlaceOrderBloc, PlaceOrderState> _cartPriceSection() {
    return BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
      builder: (context, state) {
        if (state is GetCartPlaceOrderScreenState) {
          return Column(
            children: [
              PlaceOrderCartedItemsWidget(cartList: state.cartList),
              PriceSummaryWidget(
                  length: state.cartList.length, priceMap: widget.priceBreakup),
              const SizedBox(
                height: 65,
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  BlocBuilder<AddressBloc, AddressState> _addressSection() {
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        if (state is FetchAddressCartState) {
          return AddressChangeWidget(
              callback: () => PlaceOrderCases.navigateToAddressChangeScreen(
                  context, state.user),
              userModal: state.user);
        }
        return const SizedBox(
          height: 100,
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
