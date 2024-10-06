part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class FetchCartEvent extends CartEvent{
}

class CartUpdateEvent extends CartEvent{
  final int value;
  final CartModel cartModel;
  final BuildContext context;
  CartUpdateEvent({required this.value,required this.cartModel,required this.context});
}

class RemoveFromCartEvent extends CartEvent{
final CartModel cartModel;
final BuildContext context;
RemoveFromCartEvent({required this.cartModel,required this.context});
}