part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

 class SignOutEvent extends AccountEvent{
  final VoidCallback callback;
  SignOutEvent( this.callback);
}
