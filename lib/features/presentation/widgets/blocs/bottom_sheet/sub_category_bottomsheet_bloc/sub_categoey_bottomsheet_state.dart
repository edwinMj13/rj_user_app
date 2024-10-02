part of 'sub_categoey_bottomsheet_bloc.dart';

@immutable
sealed class SubCategoeyBottomsheetState {}

final class SubCategoeyBottomsheetInitial extends SubCategoeyBottomsheetState {}

final class SubCategoeyBottomsheetSuccessState extends SubCategoeyBottomsheetState {
  final List<String> subList;

  SubCategoeyBottomsheetSuccessState({required this.subList});
}
