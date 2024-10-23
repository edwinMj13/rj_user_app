part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

 class SignOutEvent extends AccountEvent{
  final BuildContext context;
  SignOutEvent( {required this.context});
}

class RecentViewedEvent extends AccountEvent{}

class DeleteAccountEvent extends AccountEvent{
 final BuildContext context;

  DeleteAccountEvent({required this.context});
}
