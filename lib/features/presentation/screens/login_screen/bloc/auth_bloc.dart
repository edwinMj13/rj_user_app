import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    on<SignInEvent>(signInEvent);
  }

  Future<void> signInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthPendingState());
    bool userInDatabase = false;
    UserProfileModel? userProfileModel;
    final user = await authRepository.signInWithGoogle();
    await locator<AddScreenRepo>().getAllUsers().then((users){
      if(user!=null) {
        for (var userInFor in users) {
          if (userInFor.email == user.email) {
            print("userInDatabase $userInDatabase");
            userInDatabase = true;
            userProfileModel = userInFor;
            break;
          }
        }
      }
      print("USER ${user?.emailVerified}");
      print("userInDatabase $userInDatabase");

      if (user == null) {
        return emit(AuthErrorState());
      }
      if (userInDatabase == true) {
        emit(AuthUserInDatabaseState(user: userProfileModel!));
      } else {
        emit(AuthSuccessState(user));
      }
    });
  }
}
