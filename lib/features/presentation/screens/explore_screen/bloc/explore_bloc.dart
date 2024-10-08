import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/repository/explore_repo.dart';
import 'package:rj/features/domain/use_cases/explore_page_usecase.dart';
import 'package:rj/features/domain/use_cases/filter_get_use_cases.dart';

import '../../../../../utils/dependencyLocation.dart';
import '../../../../data/repository/filter_repository.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreInitial()) {
    on<ProductsFetchAllEvent>(productsFetchAllEvent);
    on<ProductsFetchFilterEvent>(productsFetchFilterEvent);
  }
  Future<void> productsFetchAllEvent(ProductsFetchAllEvent event, Emitter<ExploreState> emit) async {
    emit(ProductsLoadingExploreState());
    List<ProductsModel> productsList = await locator<ExploreRepo>().getAllProducts();
    emit(ProductsSuccessExploreState(productList: productsList));
  }

  Future<void> productsFetchFilterEvent(ProductsFetchFilterEvent event, Emitter<ExploreState> emit) async {
    emit(ProductsLoadingExploreState());
    await locator<FilterRepo>().getProductsFilter(
        event.brand, event.category, event.subCategory, event.sliderStart, event.sliderEnd).then((list){
          FilterGetDataUseCase.closeBottomSheet(event.context);
      emit(ProductsSuccessExploreState(productList: list));
    });
  }

}
