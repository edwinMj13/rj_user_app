part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LogInEvent extends AuthEvent{
final BuildContext context;
final String email;
final String password;

LogInEvent({required this.context,required this.email, required this.password, });

}


