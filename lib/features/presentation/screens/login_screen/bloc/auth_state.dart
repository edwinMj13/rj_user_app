part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthPendingState extends AuthState{}

class AuthErrorState extends AuthState{}

class AuthSuccessState extends AuthState{
  final User user;

  AuthSuccessState(this.user);
}


