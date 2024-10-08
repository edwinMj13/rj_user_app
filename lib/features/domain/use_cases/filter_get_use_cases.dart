import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:rj/features/data/models/category_model.dart';
import 'package:rj/features/data/repository/get_firebase_repo.dart';

import '../../../utils/dependencyLocation.dart';

class FilterGetDataUseCase {

  Future<List<String>> getBrands() async {
    final brandNames =await locator<GetFromFirebaseRepository>().getBrands();
    List<String> names = brandNames.map((e){
      return e.name.toString();
    }).toList();
    return names;
  }

  Future<List<String>> getCategoryNames() async {
    return locator<GetFromFirebaseRepository>().getCategoryNames();
  }

  static Future<List<String>> getSubCategories(String category) async {
    List<CategoryModel> categoryList =await locator<GetFromFirebaseRepository>().getCategories();
    CategoryModel listSub = categoryList
        .where((model) => model.categoryName==category).single;
    print(listSub);
    List<String> stringList = listSub.subCategories!.cast<String>();
    return stringList;
  }
  static closeBottomSheet(BuildContext context){
    Navigator.of(context).pop();
  }
}
