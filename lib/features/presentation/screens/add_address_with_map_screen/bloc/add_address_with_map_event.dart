part of 'add_address_with_map_bloc.dart';

@immutable
sealed class AddAddressWithMapEvent {}

class AddAddressUploadMapEvent extends AddAddressWithMapEvent {
  final AddressModel addressModel;
final BuildContext context;
  AddAddressUploadMapEvent( {required this.addressModel,required this.context});
}