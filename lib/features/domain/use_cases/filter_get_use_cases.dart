import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rj/features/data/models/category_model.dart';
import 'package:rj/features/services/fetch_services.dart';

class FilterGetDataUseCase {
  FetchServices fetchServices = FetchServices();

  Future<List<String>> getBrands() async {
    final brandNames =await fetchServices.getBrands();
    List<String> names = brandNames.map((e){
      return e.name.toString();
    }).toList();
    return names;
  }

  Future<List<String>> getCategoryNames() async {
    return fetchServices.getCategoryNames();
  }


  Future<List<String>> getSubCategories(String category) async {
    List<CategoryModel> categoryList =await fetchServices.getCategories();
    CategoryModel listSub = categoryList
        .where((model) => model.categoryName==category)
        .first;
    print(listSub);
    List<String> stringList = listSub.subCategories!.cast<String>();
    return stringList;
  }
}
