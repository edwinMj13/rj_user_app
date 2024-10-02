part of 'sub_categoey_bottomsheet_bloc.dart';

@immutable
sealed class SubCategoeyBottomsheetEvent {}

class SubCateSheetEvent extends SubCategoeyBottomsheetEvent{
  final String selectedItem;
  SubCateSheetEvent({required this.selectedItem});
}
