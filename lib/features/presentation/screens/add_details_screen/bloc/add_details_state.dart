part of 'add_details_bloc.dart';

@immutable
sealed class AddDetailsState {}

sealed class AddDetailsActionState extends AddDetailsState {}

final class AddDetailsInitial extends AddDetailsState {}

final class AddDetailsLoading extends AddDetailsState {}

final class AddDetailsSuccess extends AddDetailsState {}
