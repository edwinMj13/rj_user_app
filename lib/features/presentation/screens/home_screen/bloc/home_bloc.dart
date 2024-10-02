import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/category_model.dart';
import 'package:rj/features/services/fetch_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchDataHomeEvent>(fetchDataHomeEvent);
  }

  Future<void> fetchDataHomeEvent(FetchDataHomeEvent event, Emitter<HomeState> emit) async {
    FetchServices fetchServices = FetchServices();
    final data = await fetchServices.getCategories();
    emit(FetchDataHomeSuccessState(categoryList: data));
  }
}
