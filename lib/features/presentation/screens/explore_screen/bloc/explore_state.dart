part of 'explore_bloc.dart';

@immutable
sealed class ExploreState {}

final class ExploreInitial extends ExploreState {}

final class ProductsLoadingExploreState extends ExploreState {}
final class ProductsSuccessExploreState extends ExploreState {
  final List<ProductsModel> productList;

  ProductsSuccessExploreState({required this.productList});
}
