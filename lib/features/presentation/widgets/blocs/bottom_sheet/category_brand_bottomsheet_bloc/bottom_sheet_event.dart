part of 'bottom_sheet_bloc.dart';

@immutable
sealed class BottomSheetEvent {}
class CategoryBrandEvent extends BottomSheetEvent{

}

class SubCategorySheetEvent extends BottomSheetEvent{
  final String selectedItem;
  final String tag;
  SubCategorySheetEvent({required this.selectedItem,required this.tag});
}