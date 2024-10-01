import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../../utils/lc.dart';
import '../../../../data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInEvent>(signInEvent);
  }

  Future<void> signInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthPendingState());
    final user = await locator<AuthRepository>().signInWithGoogle();
    print("USER ${user?.emailVerified}");
    if(user==null){
      return emit(AuthErrorState());
    }
    emit(AuthSuccessState(user));
  }

}
