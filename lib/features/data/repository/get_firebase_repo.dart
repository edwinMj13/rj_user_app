import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rj/features/data/models/brand_model.dart';
import 'package:rj/features/data/models/category_model.dart';

class GetFromFirebaseRepository {
  final firebase = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async {
    final list = await firebase.collection("Categories").get();
    final listDoc = list.docs;
    List<CategoryModel> categoryList = listDoc.map((model) {
      return CategoryModel(
        imageRefPath: model["imageRefPath"],
        fireID: model["fireID"],
        status: model["status"],
        categoryName: model["categoryName"],
        image: model["image"],
        subCategories: model["subCategories"],
        id: model["id"],
      );
    }).toList();
    return categoryList;
  }

  Future<List<BrandModel>> getBrands() async {
    final list = await firebase.collection("Brands").get();
    final listDoc = list.docs;
    List<BrandModel> brandList = listDoc.map((e) {
      return BrandModel(
        id: e["id"],
        nodeId: e["nodeId"],
        imageRefPath: e["nodeId"],
        name: e["name"],
        status: e["status"],
        image: e["image"],
      );
    }).toList();
    return brandList;
  }

  Future<List<String>> getCategoryNames() async {
    final list = await firebase.collection("Categories").get();
    final listDoc = list.docs;
    List<String> categoryList = listDoc.map((e) {
      return e["categoryName"].toString();
    }).toList();
    return categoryList;
  }
}
