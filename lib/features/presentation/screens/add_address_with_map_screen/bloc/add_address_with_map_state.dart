part of 'add_address_with_map_bloc.dart';

@immutable
sealed class AddAddressWithMapState {}

final class AddAddressWithMapInitial extends AddAddressWithMapState {}

class AddAddressUploadState extends AddAddressWithMapState{

}
