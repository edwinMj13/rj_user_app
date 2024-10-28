part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}


 class SignUpUserEvent extends SignupEvent {
  final String name;
  final String email ;
  final String password;
  final BuildContext context;

  SignUpUserEvent({required this.name, required this.email, required this.password,required this.context, });

 }
