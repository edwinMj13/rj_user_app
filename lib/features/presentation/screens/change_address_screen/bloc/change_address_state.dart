part of 'change_address_bloc.dart';

@immutable
sealed class ChangeAddressState {}

final class ChangeAddressInitial extends ChangeAddressState {}

class FetchAddressChangeState extends ChangeAddressState{
  final List<AddressModel> addressList;
  final int selectedValue;
  FetchAddressChangeState({required this.addressList,required this.selectedValue});

}
