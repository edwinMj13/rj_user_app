import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/repository/add_screen_repository.dart';
import 'package:rj/features/domain/use_cases/accounts_screen_usecases.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';

import '../../../../../utils/dependencyLocation.dart';
import '../../../../data/repository/auth_repository.dart';
import '../../../../data/repository/explore_repo.dart';
import '../../../../domain/use_cases/show_loading_case.dart';
import '../../main_screen/bloc/main_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<SignOutEvent>(signOutEvent);
    on<RecentViewedEvent>(recentViewedEvent);
    on<DeleteAccountEvent>(deleteAccountEvent);
  }
  ShowLoadingCase showLoadingCase = ShowLoadingCase();

  AccountScreenUsecases accountScreenUsecases = AccountScreenUsecases();

  Future<void> signOutEvent(SignOutEvent event, Emitter<AccountState> emit) async {
    showLoadingCase.showLoading(event.context,"Logging Out...");
    await locator<AuthRepository>().googleSignOut();
    accountScreenUsecases.signOutToLoginScreen(event.context,()=>showLoadingCase.cancelLoading());
    emit(SignOutSuccessState());
  }

  Future<void> recentViewedEvent(RecentViewedEvent event, Emitter<AccountState> emit) async {
    final recentProducts = await locator<ExploreRepo>().getAllProducts();
    emit(RecentItemsSuccessState(listRecent: recentProducts));
  }

  Future<void> deleteAccountEvent(DeleteAccountEvent event, Emitter<AccountState> emit) async {
    showLoadingCase.showLoading(event.context,"Deleting Account...");
    final user = await CachedData.getUserDetails();
    await locator<AddScreenRepo>().deleteUser(user.nodeID).then((_) async {
      await locator<AuthRepository>().googleSignOut().then((_){
        accountScreenUsecases.signOutToLoginScreen(event.context,()=>showLoadingCase.cancelLoading());
        emit(DeleteAccountSuccessState());
      });
    });
  }
}

