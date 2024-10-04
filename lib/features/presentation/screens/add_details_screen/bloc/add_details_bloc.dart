import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/utils/dependencyLocation.dart';

import '../../../../data/models/user_profile_model.dart';
import '../../../../data/repository/add_screen_repository.dart';

part 'add_details_event.dart';
part 'add_details_state.dart';

class AddDetailsBloc extends Bloc<AddDetailsEvent, AddDetailsState> {
  AddDetailsBloc() : super(AddDetailsInitial()) {
    on<UploadUserDetailsEvent>(uploadUserDetails);
  }

  Future<void> uploadUserDetails(UploadUserDetailsEvent event, Emitter<AddDetailsState> emit) async {
    await locator<AddScreenRepo>().addUser(event.userDetail).then((_)=>event.callback());
  }
}
