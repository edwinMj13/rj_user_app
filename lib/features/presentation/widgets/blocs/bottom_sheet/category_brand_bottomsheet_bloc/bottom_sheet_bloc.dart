import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rj/features/domain/use_cases/filter_get_use_cases.dart';

part 'bottom_sheet_event.dart';
part 'bottom_sheet_state.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  BottomSheetBloc() : super(BottomSheetInitial()) {
    on<CategoryBrandEvent>(categoryBrandEvent);
    on<SubCategorySheetEvent>(subCategorySheetEvent);
  }
  List<String> _subCategories = [];
  List<String> get subCategories => _subCategories;

  String? _brand;
  String? get brand => _brand;

  String? _category;
  String? get category => _category;

  String? _subCategoryString;
  String? get subCategoryString => _subCategoryString;

   categoryBrandEvent(CategoryBrandEvent event, Emitter<BottomSheetState> emit) async {
    FilterGetDataUseCase filterGetDataUseCase = FilterGetDataUseCase();
    final brandList = await filterGetDataUseCase.getBrands();
    final categoryList = await filterGetDataUseCase.getCategoryNames();
    emit(CategoryBrandSuccessState(categoryList: categoryList, brandList: brandList));
  }

  Future<void> subCategorySheetEvent(SubCategorySheetEvent event, Emitter<BottomSheetState> emit) async {
     if(event.tag=="Brand"){
       _brand=event.selectedItem;
     }
     else if(event.tag=="Category"){
       _category=event.selectedItem;
     }
     else if(event.tag=="Sub-Category"){
       _subCategoryString=event.selectedItem;
     }
    _subCategories = await FilterGetDataUseCase.getSubCategories(event.selectedItem);
    print(subCategories);
    //emit();
    //emit(State(subList: subList));
  }
}
