import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rj/features/domain/use_cases/place_order_cases.dart';

part 'place_order_event.dart';
part 'place_order_state.dart';

class PlaceOrderBloc extends Bloc<PlaceOrderEvent, PlaceOrderState> {
  PlaceOrderBloc() : super(PlaceOrderInitial()) {
    on<DoPaymentEvent>(doPaymentEvent);
  }

  FutureOr<void> doPaymentEvent(DoPaymentEvent event, Emitter<PlaceOrderState> emit) {
    PlaceOrderCases.openRazorPay(event.razorpay, event.amount);
  }
}
