import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/repository/filter_get_data.dart';

part 'bottom_sheet_event.dart';
part 'bottom_sheet_state.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  BottomSheetBloc() : super(BottomSheetInitial()) {
    on<CategoryBrandEvent>(categoryBrandEvent);
  }

   categoryBrandEvent(CategoryBrandEvent event, Emitter<BottomSheetState> emit) async {
    FilterGetData filterGetData = FilterGetData();
    final brandList = await filterGetData.getBrands();
    final categoryList = await filterGetData.getCategoryNames();
    emit(CategoryBrandSuccessState(categoryList: categoryList, brandList: brandList));
  }
}
