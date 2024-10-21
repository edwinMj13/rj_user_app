import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/features/data/models/address_model.dart';
import 'package:rj/features/domain/use_cases/add_address_with_map_case.dart';
import 'package:rj/utils/text_controllers.dart';

import '../../add_address_screen/bloc/add_address_screen_bloc.dart';

part 'add_address_with_map_event.dart';
part 'add_address_with_map_state.dart';

class AddAddressWithMapBloc extends Bloc<AddAddressWithMapEvent, AddAddressWithMapState> {
  AddAddressWithMapBloc() : super(AddAddressWithMapInitial()) {
    on<AddAddressUploadMapEvent>(addAddressUploadMapEvent);
  }
  final aAddAddressWithMapCase = AddAddressWithMapCase();
  Future<void> addAddressUploadMapEvent(AddAddressUploadMapEvent event, Emitter<AddAddressWithMapState> emit) async {
    final user = await CachedData.getUserDetails();
    aAddAddressWithMapCase.addAddress(event.addressModel, user.nodeID,event.context);
    event.context.read<AddAddressScreenBloc>().add(FetchAddressScreenEvent());
  }
}
