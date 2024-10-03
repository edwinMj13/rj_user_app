import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/domain/use_cases/filter_get_use_cases.dart';

part 'sub_categoey_bottomsheet_event.dart';
part 'sub_categoey_bottomsheet_state.dart';

class SubCategoeyBottomsheetBloc extends Bloc<SubCategoeyBottomsheetEvent, SubCategoeyBottomsheetState> {
  SubCategoeyBottomsheetBloc() : super(SubCategoeyBottomsheetInitial()) {
    on<SubCateSheetEvent>(subCateSheetEvent);
  }

  subCateSheetEvent(SubCateSheetEvent event, Emitter<SubCategoeyBottomsheetState> emit) async {
    FilterGetDataUseCase filterGetDataUseCase = FilterGetDataUseCase();
    List<String> subList = await filterGetDataUseCase.getSubCategories(event.selectedItem);
    emit(SubCategoeyBottomsheetSuccessState(subList: subList));
  }
}
