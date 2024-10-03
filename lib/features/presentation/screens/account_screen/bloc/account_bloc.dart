import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/services/explore_services.dart';
import 'package:rj/utils/cached_data.dart';

import '../../../../../utils/lc.dart';
import '../../../../data/repository/auth_repository.dart';
import '../../main_screen/bloc/main_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<SignOutEvent>(signOutEvent);
    on<RecentViewedEvent>(recentViewedEvent);
  }

  Future<void> signOutEvent(SignOutEvent event, Emitter<AccountState> emit) async {
    emit(SignOutLoadingState());
    await locator<AuthRepository>().googleSignOut( () => event.callback());
    emit(SignOutSuccessState());
  }


  Future<void> recentViewedEvent(RecentViewedEvent event, Emitter<AccountState> emit) async {
    ExploreServices exploreServices = ExploreServices();
    final recentProducts = await exploreServices.getAllProducts();
    emit(RecentItemsSuccessState(listRecent: recentProducts));
  }
}

