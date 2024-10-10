part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class FetchCartSuccessState extends CartState {
  final List<CartModel> cartList;
  final UserProfileModel userModel;
  FetchCartSuccessState({required this.cartList,required this.userModel});
}

final class FetchCartNullState extends CartState {}
