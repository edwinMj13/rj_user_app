part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class FetchCartSuccess extends CartState {
  final List<CartModel> cartList;
  final UserProfileModel userModel;
  FetchCartSuccess({required this.cartList,required this.userModel});
}
