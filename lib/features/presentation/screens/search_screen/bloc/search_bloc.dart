import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/repository/explore_repo.dart';
import 'package:rj/features/domain/use_cases/search_case.dart';
import 'package:rj/utils/dependencyLocation.dart';

import '../../../../data/repository/filter_repository.dart';
import '../../../../domain/use_cases/filter_get_use_cases.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<FetchSearchResultEvent>(fetchSearchResultEvent);
    on<SearchFetchFilterEvent>(fearchFetchFilterEvent);
  }

  Future<void> fetchSearchResultEvent(FetchSearchResultEvent event, Emitter<SearchState> emit) async {
    emit(FetchSearchItemsLoadingState());
    await SearchCase.getFilteredList(event.letter.toLowerCase()).then((list){
      if(list.isNotEmpty || event.letter.isEmpty){
        emit(FetchSearchItemsSuccessState(productList: list));
      }else{
        emit(FetchSearchItemsNULLState());
      }
    });
  }
  Future<void> fearchFetchFilterEvent(SearchFetchFilterEvent event, Emitter<SearchState> emit) async {
    emit(SearchInitial());
    await locator<FilterRepo>().getProductsFilter(
        event.brand, event.category, event.subCategory, event.sliderStart, event.sliderEnd).then((list){
      FilterGetDataUseCase.clearFields(event.context);
      if(list.isNotEmpty){
        emit(FetchSearchItemsSuccessState(productList: list));
      }else{
        emit(FetchSearchItemsNULLState());
      }
    });
  }
}
