import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rj/features/data/models/products_model.dart';

class CartRepository {
  final firebase = FirebaseFirestore.instance;

  Future<List<ProductsModel>> getCarts(String userNodeId) async {
    List<ProductsModel> cartList = [];
    try {
      final data = await firebase
          .collection("Users")
          .doc(userNodeId)
          .collection("Cart")
          .get();
      final dataMap = data.docs;
      cartList = dataMap
          .map((e) => ProductsModel(
        itemName: e["itemName"],
        category: e["category"],
        firebaseNodeId: e["firebaseNodeId"],
        productId: e["productId"],
        status: e["status"],
        stock: e["stock"],
        price: e["price"],
        subCategory: e["subCategory"],
        imagesList: e["imagesList"],
        description: e["description"],
        itemBrand: e["itemBrand"],
        mainImage: e["mainImage"],
        sellingPrize: e["sellingPrize"],
      ))
          .toList();
    } catch (e) {
      print("Red Cart Exception - ${e.toString()}");
    }
    return cartList;
  }

  removeFromCart(String nodeId,String userNodId) async {
    await firebase.collection("Users").doc(userNodId).collection("Cart").doc(nodeId).delete();
  }
}
