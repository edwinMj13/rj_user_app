part of 'product_details_bloc.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class FetchProductDetailsLoadingState extends ProductDetailsState {}
final class FetchProductDetailsSuccessState extends ProductDetailsState {
  final ProductsModel productModal;
  final String userName;
  final String isInCart;
  final UserProfileModel userProfileModel;

  FetchProductDetailsSuccessState(
      {required this.productModal, required this.userName,required this.isInCart,required this.userProfileModel});
}

final class AddToCartPrdDetLoadingState extends ProductDetailsState {

}
final class AddToCartPrdDetSuccessState extends ProductDetailsState {

}

