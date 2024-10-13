part of 'place_order_bloc.dart';

@immutable
sealed class PlaceOrderState {}

final class PlaceOrderInitial extends PlaceOrderState {}

class PaymentSuccessState extends PlaceOrderState{}
