import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/features/data/models/address_model.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/data/repository/add_screen_repository.dart';
import 'package:rj/features/presentation/screens/place_order_screen/address_bloc/address_bloc.dart';
import 'package:rj/utils/dependencyLocation.dart';

import '../../../../domain/use_cases/add_address_cases.dart';

part 'change_address_event.dart';
part 'change_address_state.dart';

class ChangeAddressBloc extends Bloc<ChangeAddressEvent, ChangeAddressState> {
  ChangeAddressBloc() : super(ChangeAddressInitial()) {
    on<FetchAddressChangeEvent>(fetchAddressChangeEvent);
    on<UpdateAddressChangeEvent>(updateAddressChangeEvent);
  }
  final addAddressCases = AddAddressCases();
  Future<void> fetchAddressChangeEvent(FetchAddressChangeEvent event, Emitter<ChangeAddressState> emit) async {
   final list = await addAddressCases.getAddress(event.userNodeId);
   if(list.isNotEmpty) {
     emit(FetchAddressChangeState(
         addressList: list, selectedValue: event.selectedValue));
   }else{
     emit(FetchAddressNULLState());
   }

  }

  Future<void> updateAddressChangeEvent(UpdateAddressChangeEvent event, Emitter<ChangeAddressState> emit) async {
    final user = await CachedData.getUserDetails();
    final userModel = UserProfileModel(
      name: user.name,
      phoneNumber: user.phoneNumber,
      email: user.email,
      nodeID: user.nodeID,
      pincode:user.pincode,
      shippingAddress:event.address,
      uid: user.uid,);
    await locator<AddScreenRepo>().update(user.nodeID,userModel).then((_){
      event.context.read<AddressBloc>().add(GetAddressEvent(userNodeId:user.nodeID ));
    Navigator.of(event.context).pop();
    });
  }
}
