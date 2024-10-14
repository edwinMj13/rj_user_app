part of 'place_order_bloc.dart';

@immutable
sealed class PlaceOrderEvent {}

class DoPaymentEvent extends PlaceOrderEvent{
final Razorpay razorpay;
final int amount;

  DoPaymentEvent({required this.razorpay, required this.amount});
}

class FetchCartListPlaceOrderEvent extends PlaceOrderEvent{
  final String userNode;

  FetchCartListPlaceOrderEvent({required this.userNode});
}