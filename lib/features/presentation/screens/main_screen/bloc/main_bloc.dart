import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/cart_model.dart';

import '../../../../../utils/dependencyLocation.dart';
import '../../../../data/data_sources/cached_data.dart';
import '../../../../data/repository/auth_repository.dart';
import '../../../../data/repository/cart_repository.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super( MainInitial(index: 0)) {
    on<UpdateIndexCarBadgeEvent>(updateIndexCarBadgeEvent);
  }
  Future<void> updateIndexCarBadgeEvent(UpdateIndexCarBadgeEvent event, Emitter<MainState> emit) async {
    final user = await CachedData.getUserDetails();
    final cartList = await locator<CartRepository>().getCarts(user.nodeID);
    //emit(MainScreenIndexBadgeState(badgeCount:cartList.length,index: event.index,username: user.name));
    emit(MainScreenIndexBadgeState(index: event.index,cartLength: cartList.length,userName: user.name));
  }
}
