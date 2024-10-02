part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class FetchDataHomeSuccessState extends HomeState{
  final List<CategoryModel> categoryList;

  FetchDataHomeSuccessState({required this.categoryList});
}