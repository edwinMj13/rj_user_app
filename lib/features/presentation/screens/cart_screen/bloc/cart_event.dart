part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class FetchCartEvent extends CartEvent{

}

class RemoveFromCartEvent extends CartEvent{
final ProductsModel cartModel;
final BuildContext context;
RemoveFromCartEvent({required this.cartModel,required this.context});
}