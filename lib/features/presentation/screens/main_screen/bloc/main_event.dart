part of 'main_bloc.dart';

@immutable
sealed class MainEvent {}

class UpdateIndexCarBadgeEvent extends MainEvent {
  final int index;
  UpdateIndexCarBadgeEvent({required this.index});

}


