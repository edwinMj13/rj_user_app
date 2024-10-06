import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/domain/use_cases/category_details_case.dart';

part 'category_details_event.dart';
part 'category_details_state.dart';

class CategoryDetailsBloc extends Bloc<CategoryDetailsEvent, CategoryDetailsState> {
  CategoryDetailsBloc() : super(CategoryDetailsInitial()) {
    on<CategoryListEvent>(categoryListEvent);
  }
  CategoryDetailsCase categoryDetailsCase = CategoryDetailsCase();
  Future<void> categoryListEvent(CategoryListEvent event, Emitter<CategoryDetailsState> emit) async {
    emit(CategoryDetailsInitial());
    print("categoryListEvent - BLOC INITIAL - ${event.categoryName}");
    final list = await categoryDetailsCase.getCategoryProductsList(event.categoryName);
    print("categoryListEvent - BLOC - ${list}");
    emit(FetchCategoryDetailsState(productList: list));
  }
}
