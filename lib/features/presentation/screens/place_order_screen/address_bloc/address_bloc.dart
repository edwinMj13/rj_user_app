import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/user_profile_model.dart';

import '../../../../../utils/dependencyLocation.dart';
import '../../../../data/models/address_model.dart';
import '../../../../data/models/cart_model.dart';
import '../../../../data/repository/add_address_repository.dart';
import '../../../../data/repository/add_screen_repository.dart';
import '../../../../domain/use_cases/show_loading_case.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<GetAddressEvent>(getAddressEvent);
  }
  ShowLoadingCase showLoadingCase =ShowLoadingCase();

  Future<void> getAddressEvent(GetAddressEvent event, Emitter<AddressState> emit) async {

    await locator<AddScreenRepo>().getUserDetails(event.userNodeId).then((user){
      emit(FetchAddressCartState(user: user));
    });

  }
}
