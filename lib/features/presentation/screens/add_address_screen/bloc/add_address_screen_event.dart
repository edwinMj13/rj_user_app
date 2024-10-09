part of 'add_address_screen_bloc.dart';

@immutable
sealed class AddAddressScreenEvent {}

class FetchAddressScreenEvent extends AddAddressScreenEvent{}

class AddUpdloadAddressScreenEvent extends AddAddressScreenEvent{

}

class AddAddressScreenUpdateEvent extends AddAddressScreenEvent{
final String addressNodeId;
final AddressModel addressModel;
final BuildContext context;

  AddAddressScreenUpdateEvent({required this.addressNodeId,required this.addressModel,required this.context});
}

class AddAddressScreenDeleteEvent extends AddAddressScreenEvent{
  final String addressNodeId;
  final BuildContext context;

  AddAddressScreenDeleteEvent({required this.addressNodeId,required this.context});
}
