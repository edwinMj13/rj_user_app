import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/domain/use_cases/edit_profile_cases.dart';
import 'package:rj/utils/text_controllers.dart';

import '../../../../../utils/dependencyLocation.dart';
import '../../../../data/repository/add_screen_repository.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<UpdateProfileEvent>(updateProfileEvent);
  }

  Future<void> updateProfileEvent(
      UpdateProfileEvent event, Emitter<EditProfileState> emit) async {
    final user = UserProfileModel(
      name: nameEditProfileController.text,
      phoneNumber: phoneEditProfileController.text,
      email: emailEditProfileController.text,
      pincode: event.user.pincode,
      nodeID: event.user.nodeID,
      uid: event.user.uid,
      shippingAddress: event.user.shippingAddress
    );
    await locator<AddScreenRepo>().update(user.nodeID, user).then((_){
      emit(EditProfileEditedState());
    });
    (user);
  }
}
