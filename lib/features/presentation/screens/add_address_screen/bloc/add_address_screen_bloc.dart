import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/features/data/models/address_model.dart';
import 'package:rj/features/data/repository/add_address_repository.dart';
import 'package:rj/features/domain/use_cases/add_address_cases.dart';
import 'package:rj/utils/dependencyLocation.dart';
import 'package:rj/utils/text_controllers.dart';

part 'add_address_screen_event.dart';
part 'add_address_screen_state.dart';

class AddAddressScreenBloc extends Bloc<AddAddressScreenEvent, AddAddressScreenState> {
  AddAddressScreenBloc() : super(AddAddressScreenInitial()) {
    on<FetchAddressScreenEvent>(fetchAddressScreenEvent);
    on<AddUpdloadAddressScreenEvent>(addUpdloadAddressScreenEvent);
    on<AddAddressScreenUpdateEvent>(addAddressScreenUpdateEvent);
    on<AddAddressScreenDeleteEvent>(addAddressScreenDeleteEvent);
  }
AddAddressCases addAddressCases = AddAddressCases();
  Future<void> fetchAddressScreenEvent(FetchAddressScreenEvent event, Emitter<AddAddressScreenState> emit) async {
    final user = await CachedData.getUserDetails();
    final addressList = await addAddressCases.getAddress(user.nodeID);
    if(addressList.isNotEmpty) {
      emit(FetchAddressState(addressList: addressList));
    }else {
      emit(FetchAddressScreenNullState());
    }
  }

  FutureOr<void> addUpdloadAddressScreenEvent(AddUpdloadAddressScreenEvent event, Emitter<AddAddressScreenState> emit) async {
    final user = await CachedData.getUserDetails();
    final model = AddressModel(
        addressNodeId: "",
        address: addAddressAddressController.text,
        addressName: addAddressNameController.text,
        addressPinCode: addAddressPincodeController.text);
    locator<AddAddressRepo>().uploadAddress(model, user.nodeID);
  }

  Future<void> addAddressScreenUpdateEvent(AddAddressScreenUpdateEvent event, Emitter<AddAddressScreenState> emit) async {
    final user = await CachedData.getUserDetails();
    await addAddressCases.updateAddress(user.nodeID, event.addressNodeId, event.addressModel).then((_){
      Navigator.of(event.context).pop();
    });
    final addressList = await addAddressCases.getAddress(user.nodeID);
    if(addressList.isNotEmpty) {
      emit(FetchAddressState(addressList: addressList));
    }else {
      emit(FetchAddressScreenNullState());
    }
  }

  FutureOr<void> addAddressScreenDeleteEvent(AddAddressScreenDeleteEvent event, Emitter<AddAddressScreenState> emit) async {
    final user = await CachedData.getUserDetails();
    await addAddressCases.deleteAddress(user.nodeID, event.addressNodeId).then((_){
      Navigator.of(event.context).pop();
    });
    final addressList = await addAddressCases.getAddress(user.nodeID);
    if(addressList.isNotEmpty) {
      emit(FetchAddressState(addressList: addressList));
    }else {
      emit(FetchAddressScreenNullState());
    }
  }
}
