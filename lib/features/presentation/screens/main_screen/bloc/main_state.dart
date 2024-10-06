part of 'main_bloc.dart';

@immutable
sealed class MainState {
  final int index;MainState({required this.index});
}

final class MainInitial extends MainState {
  MainInitial({required super.index});
}
final class MainScreenIndexBadgeState extends MainState {
  final String? userName;
  final int? cartLength;
  MainScreenIndexBadgeState({required super.index, this.cartLength , this.userName});
}

