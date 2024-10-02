part of 'product_details_bloc.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class FetchProductDetailsLoadingState extends ProductDetailsState {}
final class FetchProductDetailsSuccessState extends ProductDetailsState {
  final ProductsModel productModal;
  final String userName;
  FetchProductDetailsSuccessState({required this.productModal,required this.userName});

}

