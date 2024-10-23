part of 'account_bloc.dart';

@immutable
sealed class AccountState {}

final class AccountInitial extends AccountState {}

final class SignOutLoadingState extends AccountState{

}

final class SignOutSuccessState extends AccountState{}

final class DeleteAccountSuccessState extends AccountState{}

final class RecentItemsSuccessState extends AccountState{
  final List<ProductsModel> listRecent;
  RecentItemsSuccessState({required this.listRecent});
}


