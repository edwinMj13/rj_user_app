part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class FetchDataHomeSuccessState extends HomeState{
  final List<CategoryModel> categoryList;
  final List<BrandModel> brandList;
  final BannerModel bannerModel;
  final List<ProductsModel> priceDropList;
  FetchDataHomeSuccessState({required this.priceDropList,required this.categoryList,required this.brandList, required this.bannerModel, });
}