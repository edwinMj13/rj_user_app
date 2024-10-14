part of 'address_bloc.dart';

@immutable
sealed class AddressState {}

final class AddressInitial extends AddressState {}

class FetchAddressCartState extends AddressState{
  final UserProfileModel user;

  FetchAddressCartState({required this.user});
}