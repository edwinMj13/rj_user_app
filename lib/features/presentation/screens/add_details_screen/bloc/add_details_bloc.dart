import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/utils/lc.dart';

import '../../../../data/models/user_profile_model.dart';
import '../../../../data/repository/firebse_methods.dart';

part 'add_details_event.dart';
part 'add_details_state.dart';

class AddDetailsBloc extends Bloc<AddDetailsEvent, AddDetailsState> {
  AddDetailsBloc() : super(AddDetailsInitial()) {
    on<UploadUserDetailsEvent>(uploadUserDetails);
  }

  Future<void> uploadUserDetails(UploadUserDetailsEvent event, Emitter<AddDetailsState> emit) async {
    await locator<FirebaseMethods>().addUser(event.userDetail).then((_)=>event.callback());
  }
}
