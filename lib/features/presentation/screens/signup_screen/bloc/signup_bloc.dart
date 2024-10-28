import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rj/utils/common.dart';

import '../../../../../utils/dependencyLocation.dart';
import '../../../../data/repository/auth_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent,SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignUpUserEvent>(signUpUserEvent);
  }

  Future<void> signUpUserEvent(SignUpUserEvent event, Emitter<SignupState> emit) async {
    final data = await locator<AuthRepository>().createUserWithEmailAndPassword(event.email, event.password);
    switch(data.runtimeType){
      case String:
        final message = data as String;
        snackbar(event.context, message);
      case User:
        snackbar(event.context, "User Successfully Registered");
        Navigator.of(event.context).pop();
        break;
    }
  }
}
