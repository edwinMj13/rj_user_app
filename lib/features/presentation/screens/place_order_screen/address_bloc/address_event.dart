part of 'address_bloc.dart';

@immutable
sealed class AddressEvent {}
class GetAddressEvent extends AddressEvent {
  final String userNodeId;

  GetAddressEvent({required this.userNodeId});
}