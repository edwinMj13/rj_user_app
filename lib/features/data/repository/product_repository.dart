import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rj/features/data/models/category_model.dart';
import 'package:rj/features/data/models/products_model.dart';

class ProductRepo {
  final firebase = FirebaseFirestore.instance;

  Future<ProductsModel> getProductDetails(String nodeId) async {
    final data = await firebase.collection("Products").doc(nodeId).get();
    final dataDoc = data.data();
    final model =
        ProductsModel(
          itemName: dataDoc!["itemName"],
          category: dataDoc["category"],
          firebaseNodeId: dataDoc["firebaseNodeId"],
          status: dataDoc["status"],
          imagesList: dataDoc["imagesList"],
          description: dataDoc["description"],
          itemBrand: dataDoc["itemBrand"],
          mainImage: dataDoc["mainImage"],
          sellingPrize: dataDoc["sellingPrize"],);
    return model;
  }


}