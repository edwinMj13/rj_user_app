part of 'category_details_bloc.dart';

@immutable
sealed class CategoryDetailsEvent {}

class CategoryListEvent extends CategoryDetailsEvent {
  final String categoryName;

  CategoryListEvent({required this.categoryName});

}

class CategoryFetchFilterEvent extends CategoryDetailsEvent{
  final String brand;
  final String category;
  final String subCategory;
  final double sliderStart;
  final double sliderEnd;
  final BuildContext context;

  CategoryFetchFilterEvent({required this.context,required this.brand, required this.category, required this.subCategory, required this.sliderStart, required this.sliderEnd});

}
