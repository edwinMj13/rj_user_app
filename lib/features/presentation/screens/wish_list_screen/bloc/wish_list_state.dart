part of 'wish_list_bloc.dart';

@immutable
sealed class WishListState {}

final class WishListInitial extends WishListState {}


final class FetchWishListSuccessState extends WishListState {
  final List<ProductsModel> productsModel;

  FetchWishListSuccessState({required this.productsModel});
}

final class FetchWishListNullState extends WishListState {}
