part of 'place_order_bloc.dart';

@immutable
sealed class PlaceOrderState {}

final class PlaceOrderInitial extends PlaceOrderState {}

class PaymentSuccessState extends PlaceOrderState{}

class GetCartPlaceOrderScreenState extends PlaceOrderState{
  final List<CartModel> cartList;

  GetCartPlaceOrderScreenState({required this.cartList});
}

