import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rj/features/data/models/to_model_class.dart';

import '../models/products_model.dart';

class SearchRepository{
  final firebase = FirebaseFirestore.instance;

Future<List<ProductsModel>> getFilteredProducts(String letter) async {
    List<ProductsModel> productList = [];
    try {
      final data = await firebase.collection("Products").where("itemName",arrayContains: "C").get();
      print("SEARCH SCREEN $data");
      final dataDocs = data.docs;
      productList = dataDocs.map((model) {
        print("{model[""]}    ${model["itemName"]}");
        //return ToModelClass.toProductModel(model);
        return ProductsModel(
          itemName: model["itemName"],
          category: model["category"],
          firebaseNodeId: model["firebaseNodeId"],
          itemMrp: model["itemMrp"],
          productId: model["firebaseNodeId"],
          //totalMrp: model["totalMrp"],
          status: model["status"],
          imagesList: model["imagesList"],
          description: model["description"],
          offerAmount: model["offerAmount"],
          offerPercent: model["offerPercent"],
          itemAddedDate: model["itemAddedDate"],
          mainImage: model["mainImage"],
          itemBrand: model["itemBrand"],
          sellingPrize: model["sellingPrize"],
          price: model["price"],
          stock: model["stock"],
          subCategory: model["subCategory"],
        );
      }).toList();
      print("DATAAA FILTER $productList");
    } catch (e) {
      print("Products FILTER Read Exception ${e.toString()}");
    }
    return productList;
  }

}