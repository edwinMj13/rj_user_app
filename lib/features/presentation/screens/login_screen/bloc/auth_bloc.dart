import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/data/repository/add_screen_repository.dart';

import '../../../../../utils/dependencyLocation.dart';
import '../../../../data/repository/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LogInEvent>(signInEvent);
  }

  Future<void> signInEvent(LogInEvent event, Emitter<AuthState> emit) async {
    emit(AuthPendingState());
    bool userInDatabase = false;
    UserProfileModel? userProfileModel;
    final data = await authRepository.signInUserWithEmailAndPassword(event.email, event.password);
    print("Login data.runtimeType   - ${data.runtimeType}");
    switch(data.runtimeType){
      case User:
        final user = data as User;
        await locator<AddScreenRepo>().getAllUsers().then((users) {
          for (var userInFor in users) {
            if (userInFor.email == user.email) {
              print("userInDatabase $userInDatabase");
              userInDatabase = true;
              userProfileModel = userInFor;
              break;
            }
          }
                  print("USER ${user.emailVerified}");
          print("USER DETAILS $user");
          print("userInDatabase $userInDatabase");
          print("userProfileModel $userProfileModel");


          if (userInDatabase == true) {
            emit(AuthUserInDatabaseState(user: userProfileModel!));
          } else {
            emit(AuthSuccessState(user));
          }
        });
        break;
      case String:
        emit(AuthErrorState(message: data.toString()));
        break;

    }
  }
}
