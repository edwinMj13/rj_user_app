part of 'product_details_bloc.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}


final class CheckInWishListOrCartState extends ProductDetailsState {
  // final ProductsModel productModal;
  // final String userName;
  // final UserProfileModel userProfileModel;
  final String isInCart;
  final String isInWishList;

  CheckInWishListOrCartState({
    // required this.productModal,
    // required this.userName,
    // required this.userProfileModel,
    required this.isInCart,
    required this.isInWishList,
  });
}

final class AddToCartPrdDetLoadingState extends ProductDetailsState {}

final class AddToCartPrdDetSuccessState extends ProductDetailsState {}
