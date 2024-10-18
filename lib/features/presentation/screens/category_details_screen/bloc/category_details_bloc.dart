import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/repository/filter_repository.dart';
import 'package:rj/features/domain/use_cases/category_details_case.dart';
import 'package:rj/features/domain/use_cases/filter_get_use_cases.dart';

import '../../../../../utils/dependencyLocation.dart';
import '../../../../data/repository/explore_repo.dart';
import '../../../../domain/use_cases/explore_page_usecase.dart';

part 'category_details_event.dart';
part 'category_details_state.dart';

class CategoryDetailsBloc extends Bloc<CategoryDetailsEvent, CategoryDetailsState> {
  CategoryDetailsBloc() : super(CategoryDetailsInitial()) {
    on<CategoryListEvent>(categoryListEvent);
    on<CategoryFetchFilterEvent>(categoryFetchFilterEvent);
  }
  CategoryDetailsCase categoryDetailsCase = CategoryDetailsCase();
  Future<void> categoryListEvent(CategoryListEvent event, Emitter<CategoryDetailsState> emit) async {
    emit(CategoryDetailsInitial());
    print("categoryListEvent - BLOC INITIAL - ${event.categoryName}");
    final list = await categoryDetailsCase.getCategoryProductsList(event.categoryName);
    print("categoryListEvent - BLOC - ${list}");
    emit(FetchCategoryDetailsState(productList: list));
  }
  Future<void> categoryFetchFilterEvent(CategoryFetchFilterEvent event, Emitter<CategoryDetailsState> emit) async {
    emit(CategoryDetailsInitial());
    await locator<FilterRepo>().getProductsFilter(
        event.brand, event.category, event.subCategory, event.sliderStart, event.sliderEnd).then((list){
          if(list.isNotEmpty) {
            emit(FetchCategoryDetailsState(productList: list));
            FilterGetDataUseCase.clearFields(event.context);
          }else{
            emit(FetchCategoryDetailsNULLState());
          }
    });
  }
}
