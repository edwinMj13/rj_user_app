import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rj/features/data/models/category_model.dart';
import 'package:rj/features/data/models/products_model.dart';

import '../data_sources/cached_data.dart';

class ProductRepo {
  final firebase = FirebaseFirestore.instance;

  Future<ProductsModel> getProductDetails(String nodeId) async {
    final data = await firebase.collection("Products").doc(nodeId).get();
    final dataDoc = data.data();
    final model = ProductsModel(
      itemName: dataDoc!["itemName"],
      itemMrp: dataDoc["itemMrp"],
      category: dataDoc["category"],
      totalMrp: dataDoc["totalMrp"],
      productId: dataDoc["productId"],
      firebaseNodeId: dataDoc["firebaseNodeId"],
      status: dataDoc["status"],
      imagesList: dataDoc["imagesList"],
      description: dataDoc["description"],
      itemBrand: dataDoc["itemBrand"],
      subCategory: dataDoc["subCategory"],
      price: dataDoc["price"],
      stock: dataDoc["stock"],
      mainImage: dataDoc["mainImage"],
      sellingPrize: dataDoc["sellingPrize"],
    );
    return model;
  }
}
