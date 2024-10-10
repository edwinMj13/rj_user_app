import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/category_model.dart';
import 'package:rj/features/data/repository/get_firebase_repo.dart';

import '../../../utils/common.dart';
import '../../../utils/dependencyLocation.dart';
import '../../presentation/screens/category_details_screen/bloc/category_details_bloc.dart';
import '../../presentation/screens/explore_screen/bloc/explore_bloc.dart';

class FilterGetDataUseCase {

  static ValueNotifier<bool> hasError = ValueNotifier(false);

  Future<List<String>> getBrands() async {
    final brandNames = await locator<GetFromFirebaseRepository>().getBrands();
    List<String> names = brandNames.map((e) {
      return e.name.toString();
    }).toList();
    return names;
  }

  Future<List<String>> getCategoryNames() async {
    return locator<GetFromFirebaseRepository>().getCategoryNames();
  }

  static Future<List<String>> getSubCategories(String category) async {
    List<CategoryModel> categoryList =
        await locator<GetFromFirebaseRepository>().getCategories();
    CategoryModel listSub =
        categoryList.where((model) => model.categoryName == category).first;
    print(listSub);
    List<String> stringList = listSub.subCategories!.cast<String>();
    return stringList;
  }

  static closeBottomSheet(BuildContext context) {
    Navigator.of(context).pop();
  }

  static ValueNotifier<String> brandNotifier = ValueNotifier("Select");
  static ValueNotifier<String> categoryNotifier = ValueNotifier("Select");
  static ValueNotifier<String> subCategoryNotifier = ValueNotifier("Select");


  static updateBrand(String value) => brandNotifier.value = value;

  static updateCategory(String value) => categoryNotifier.value = value;

  static updateSubCategory(String value) => subCategoryNotifier.value = value;

  static ValueNotifier<List<String>> brandListNotifier = ValueNotifier([]);
  static ValueNotifier<List<String>> categoryListNotifier = ValueNotifier([]);
  static ValueNotifier<List<String>> subCategoryListNotifier = ValueNotifier([]);

  static getBrandList(List<String> list) => brandListNotifier.value = list;
  static getCategoryList(List<String> list) => categoryListNotifier.value = list;
  static getSubCategoryList(List<String> list) => subCategoryListNotifier.value = list;

  static selectFromPopupDialog(String selectedValue, BuildContext context,String label) async {
    if (label == "Brand") {
      FilterGetDataUseCase.updateBrand(selectedValue);
    } else if (label == "Category") {
      final subCategories =
      await FilterGetDataUseCase.getSubCategories(
          selectedValue);
      FilterGetDataUseCase.getSubCategoryList(
          subCategories);
      FilterGetDataUseCase.updateSubCategory("Select");
      FilterGetDataUseCase.updateCategory(selectedValue);
    } else if (label == "Sub-Category") {
      FilterGetDataUseCase.updateSubCategory(selectedValue);
    }

    Navigator.of(context).pop();
  }

  static clearFields(BuildContext context){
    FilterGetDataUseCase.updateSubCategory("Select");
    FilterGetDataUseCase.updateCategory("Select");
    FilterGetDataUseCase.updateBrand("Select");
    Navigator.of(context).pop();
  }

  static showFilterResults(String tag,BuildContext context) {
    final bran = FilterGetDataUseCase.brandNotifier.value;
    final cate = FilterGetDataUseCase.categoryNotifier.value;
    final sub = FilterGetDataUseCase.subCategoryNotifier.value;
    if(bran!="Select" && cate!="Select" && sub!="Select") {
      updateHasError(false);
      print(
          "bran - $bran   sub - $sub   cate - $cate   slidStart - $sliderStart   sliderEnd - $sliderEnd");
      if (tag == "ExP") {
        context.read<ExploreBloc>().add(ProductsFetchFilterEvent(
          brand: bran,
          category: cate,
          subCategory: sub,
          sliderStart: sliderStart!,
          context: context,
          sliderEnd: sliderEnd!,
        ));
      } else {
        context.read<CategoryDetailsBloc>().add(CategoryFetchFilterEvent(
          brand: bran,
          category: cate,
          subCategory: sub,
          sliderStart: sliderStart!,
          context: context,
          sliderEnd: sliderEnd!,
        ));
      }
    }else{
      updateHasError(true);
    }
  }

  static updateHasError(bool status){
    hasError.value=status;
  }


}
