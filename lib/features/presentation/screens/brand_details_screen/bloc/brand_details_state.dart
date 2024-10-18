part of 'brand_details_bloc.dart';

@immutable
sealed class BrandDetailsState {}

final class BrandDetailsInitial extends BrandDetailsState {}

class FetchProductsOfBrandSuccessState extends BrandDetailsState{
  final List<ProductsModel> productList;

  FetchProductsOfBrandSuccessState({required this.productList});
}

class FetchProductsOfBrandNULLState extends BrandDetailsState {}
