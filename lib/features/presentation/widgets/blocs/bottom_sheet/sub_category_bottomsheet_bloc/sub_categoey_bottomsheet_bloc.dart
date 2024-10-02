import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/data/repository/filter_get_data.dart';

part 'sub_categoey_bottomsheet_event.dart';
part 'sub_categoey_bottomsheet_state.dart';

class SubCategoeyBottomsheetBloc extends Bloc<SubCategoeyBottomsheetEvent, SubCategoeyBottomsheetState> {
  SubCategoeyBottomsheetBloc() : super(SubCategoeyBottomsheetInitial()) {
    on<SubCateSheetEvent>(subCateSheetEvent);
  }

  subCateSheetEvent(SubCateSheetEvent event, Emitter<SubCategoeyBottomsheetState> emit) async {
    FilterGetData filterGetData = FilterGetData();
    List<String> subList = await filterGetData.getSubCategories(event.selectedItem);
    emit(SubCategoeyBottomsheetSuccessState(subList: subList));
  }
}
