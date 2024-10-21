part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

class UpdateProfileEvent extends EditProfileEvent {
  final String userNode;
  final UserProfileModel user;

  UpdateProfileEvent({required this.userNode, required this.user});
}