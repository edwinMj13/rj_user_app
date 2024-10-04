part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

 class SignOutEvent extends AccountEvent{
  final BuildContext context;
  SignOutEvent( {required this.context});
}

class RecentViewedEvent extends AccountEvent{

}
