part of 'category_details_bloc.dart';

@immutable
sealed class CategoryDetailsEvent {}

class CategoryListEvent extends CategoryDetailsEvent {
  final String categoryName;

  CategoryListEvent({required this.categoryName});

}
