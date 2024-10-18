part of 'category_details_bloc.dart';

@immutable
sealed class CategoryDetailsState {}

final class CategoryDetailsInitial extends CategoryDetailsState {}

final class FetchCategoryDetailsState extends CategoryDetailsState {
  final List<ProductsModel> productList;

  FetchCategoryDetailsState({required this.productList});

}

class FetchCategoryDetailsNULLState extends CategoryDetailsState{}