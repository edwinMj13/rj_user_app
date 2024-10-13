part of 'place_order_bloc.dart';

@immutable
sealed class PlaceOrderEvent {}

class DoPaymentEvent extends PlaceOrderEvent{
final Razorpay razorpay;
final double amount;

  DoPaymentEvent({required this.razorpay, required this.amount});
}