import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/products_model.dart';

import '../../../../../utils/dependencyLocation.dart';
import '../../../../data/repository/filter_repository.dart';
import '../../../../domain/use_cases/brand_details_case.dart';
import '../../../../domain/use_cases/filter_get_use_cases.dart';
import '../../explore_screen/bloc/explore_bloc.dart';

part 'brand_details_event.dart';
part 'brand_details_state.dart';

class BrandDetailsBloc extends Bloc<BrandDetailsEvent, BrandDetailsState> {
  BrandDetailsBloc() : super(BrandDetailsInitial()) {
    on<FetchBrandDetailsEvent>(fetchBrandDetailsEvent);
    on<BrandFetchFilterEvent>(brandFetchFilterEvent);
  }

  Future<void> fetchBrandDetailsEvent(FetchBrandDetailsEvent event, Emitter<BrandDetailsState> emit) async {
    await BrandDetailsUseCase.getProductsOfBrand(event.brand).then((productList){
      if(productList.isNotEmpty){
        emit(FetchProductsOfBrandSuccessState(productList: productList));
      }else{
        emit(FetchProductsOfBrandNULLState());
      }
    });
  }

  Future<void> brandFetchFilterEvent(BrandFetchFilterEvent event, Emitter<BrandDetailsState> emit) async {
    emit(BrandDetailsInitial());
    await locator<FilterRepo>().getProductsFilter(
    event.brand, event.category, event.subCategory, event.sliderStart, event.sliderEnd).then((list){
    FilterGetDataUseCase.clearFields(event.context);
    if(list.isNotEmpty){
      emit(FetchProductsOfBrandSuccessState(productList: list));
    }else{
      emit(FetchProductsOfBrandNULLState());
    }
    });
  }
}