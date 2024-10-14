import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rj/features/data/models/address_model.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/repository/add_address_repository.dart';
import 'package:rj/features/data/repository/cart_repository.dart';
import 'package:rj/features/domain/use_cases/place_order_cases.dart';
import 'package:rj/features/domain/use_cases/show_loading_case.dart';
import 'package:rj/utils/dependencyLocation.dart';

part 'place_order_event.dart';

part 'place_order_state.dart';

class PlaceOrderBloc extends Bloc<PlaceOrderEvent, PlaceOrderState> {
  PlaceOrderBloc() : super(PlaceOrderInitial()) {
    on<DoPaymentEvent>(doPaymentEvent);
    on<FetchCartListPlaceOrderEvent>(fetchCartListPlaceOrderEvent);
  }

  FutureOr<void> doPaymentEvent(DoPaymentEvent event,
      Emitter<PlaceOrderState> emit) {
    PlaceOrderCases.openRazorPay(event.razorpay, event.amount);
  }

  Future<void> fetchCartListPlaceOrderEvent(FetchCartListPlaceOrderEvent event,
      Emitter<PlaceOrderState> emit) async {
    await locator<CartRepository>().getCarts(event.userNode).then((list) {
      emit(GetCartPlaceOrderScreenState(cartList:list));
    });
  }
}
