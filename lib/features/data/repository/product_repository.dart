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
      category: dataDoc["category"],
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

  Future<void> addToCart(ProductsModel model, String nodeId) async {
    try {
      await firebase
          .collection("Users")
          .doc(nodeId)
          .collection("Cart")
          .add(model.toMap())
          .then((node) async {
        final poducts = ProductsModel(
          itemName: model.itemName,
          category: model.category,
          productId: model.firebaseNodeId,
          firebaseNodeId: node.id,
          status: model.status,
          imagesList: model.imagesList,
          description: model.description,
          itemBrand: model.itemBrand,
          mainImage: model.mainImage,
          sellingPrize: model.sellingPrize,
          stock: model.stock,
          price: model.price,
          subCategory: model.subCategory,
        );
        await firebase
            .collection("Users")
            .doc(nodeId)
            .collection("Cart")
            .doc(node.id)
            .update(poducts.toMap());
      });
    } catch (e) {
      print("Adding To Cart Exception - ${e.toString()}");
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getProductsInCart(String prodId, String nodeID) async {
    final data =
        await firebase.collection("Users").doc(nodeID).collection("Cart").get();
    final mapData = data.docs;
    return mapData;
   // print(r);
  }
}
