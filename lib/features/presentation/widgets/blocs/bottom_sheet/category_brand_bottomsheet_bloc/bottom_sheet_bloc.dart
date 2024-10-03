import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/domain/use_cases/filter_get_use_cases.dart';

part 'bottom_sheet_event.dart';
part 'bottom_sheet_state.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  BottomSheetBloc() : super(BottomSheetInitial()) {
    on<CategoryBrandEvent>(categoryBrandEvent);
  }

   categoryBrandEvent(CategoryBrandEvent event, Emitter<BottomSheetState> emit) async {
    FilterGetDataUseCase filterGetDataUseCase = FilterGetDataUseCase();
    final brandList = await filterGetDataUseCase.getBrands();
    final categoryList = await filterGetDataUseCase.getCategoryNames();
    emit(CategoryBrandSuccessState(categoryList: categoryList, brandList: brandList));
  }
}
