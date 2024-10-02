import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/services/explore_services.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreInitial()) {
    on<ProductsFetchAllEvent>(productsFetchAllEvent);
  }

  Future<void> productsFetchAllEvent(ProductsFetchAllEvent event, Emitter<ExploreState> emit) async {
    ExploreServices exploreServices = ExploreServices();
    emit(ProductsLoadingExploreState());
    List<ProductsModel> productsList = await exploreServices.getAllProducts();
    emit(ProductsSuccessExploreState(productList: productsList));
  }
}
