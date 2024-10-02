part of 'bottom_sheet_bloc.dart';

@immutable
sealed class BottomSheetState {}

final class BottomSheetInitial extends BottomSheetState {}

final class CategoryBrandSuccessState extends BottomSheetState{
  final List<String> brandList;
  final List<String> categoryList;
  CategoryBrandSuccessState({required this.categoryList,required this.brandList});
}
