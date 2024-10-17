part of 'add_address_screen_bloc.dart';

@immutable
sealed class AddAddressScreenState {}

final class AddAddressScreenInitial extends AddAddressScreenState {}

class FetchAddressState extends AddAddressScreenState {
  final List<AddressModel> addressList;

  FetchAddressState({required this.addressList});

}
class FetchAddressScreenNullState extends AddAddressScreenState{}