part of 'brand_details_bloc.dart';

@immutable
sealed class BrandDetailsEvent {}

class FetchBrandDetailsEvent extends BrandDetailsEvent{
  final String brand;

  FetchBrandDetailsEvent({required this.brand});

}


class BrandFetchFilterEvent extends BrandDetailsEvent{
  final String brand;
  final String category;
  final String subCategory;
  final double sliderStart;
  final double sliderEnd;
  final BuildContext context;

  BrandFetchFilterEvent({required this.context,required this.brand, required this.category, required this.subCategory, required this.sliderStart, required this.sliderEnd});

}
