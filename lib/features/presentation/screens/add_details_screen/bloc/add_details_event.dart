part of 'add_details_bloc.dart';

abstract class AddDetailsEvent {}

class UploadUserDetailsEvent extends AddDetailsEvent {
  final UserProfileModel userDetail;
  final VoidCallback callback;
  UploadUserDetailsEvent({required this.userDetail, required this.callback});
}
