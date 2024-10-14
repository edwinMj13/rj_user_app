part of 'change_address_bloc.dart';

@immutable
sealed class ChangeAddressEvent {}

class FetchAddressChangeEvent extends ChangeAddressEvent{
final int selectedValue;
final String userNodeId;

  FetchAddressChangeEvent({required this.selectedValue,required this.userNodeId});
}

class UpdateAddressChangeEvent extends ChangeAddressEvent {

  final String address;
  final BuildContext context;

  UpdateAddressChangeEvent({required this.address, required this.context});

}