import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/brand_model.dart';
import 'package:rj/features/data/models/category_model.dart';
import 'package:rj/features/data/repository/get_firebase_repo.dart';

import '../../../../../utils/dependencyLocation.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchDataHomeEvent>(fetchDataHomeEvent);
  }

  Future<void> fetchDataHomeEvent(
      FetchDataHomeEvent event, Emitter<HomeState> emit) async {
    final categoryList = await locator<GetFromFirebaseRepository>().getCategories();
    final brandsList = await locator<GetFromFirebaseRepository>().getBrands();
    emit(FetchDataHomeSuccessState(categoryList: categoryList,brandList: brandsList));
  }
}
