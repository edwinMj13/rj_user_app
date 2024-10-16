import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/products_model.dart';

class CartRepository {
  final firebase = FirebaseFirestore.instance;

  Future<List<CartModel>> getCarts(String userNodeId) async {
    List<CartModel> cartList = [];
    try {
      final data = await firebase
          .collection("Users")
          .doc(userNodeId)
          .collection("Cart")
          .get();
      final dataMap = data.docs;
      cartList = dataMap
          .map((e) {
            final mrp = e["totalMrp"]=="" ?e["itemMrp"]:e["totalMrp"];
        return CartModel(
                itemName: e["itemName"],
                category: e["category"],
                firebaseNodeId: e["firebaseNodeId"],
                totalMrp: mrp,
                productId: e["productId"],
                itemMrp: e["itemMrp"],
                status: e["status"],
                stock: e["stock"],
                totalAmount: e["totalAmount"],
                cartedQuantity: e["cartedQuantity"],
                price: e["price"],
                subCategory: e["subCategory"],
                imagesList: e["imagesList"],
                description: e["description"],
                itemBrand: e["itemBrand"],
                mainImage: e["mainImage"],
                sellingPrize: e["sellingPrize"],
              );})
          .toList();
    } catch (e) {
      print("Red Cart Exception - ${e.toString()}");
    }
    return cartList;
  }

  Future<void> addToCart(ProductsModel model, String userNodeId) async {
    print("${model.itemMrp}        ${model.totalMrp}");
    try {
      await firebase
          .collection("Users")
          .doc(userNodeId)
          .collection("Cart")
          .add(model.toMap())
          .then((node) async {
        final poducts = CartModel(
          itemName: model.itemName,
          cartedQuantity: 1,
          totalAmount: int.parse(model.sellingPrize),
          category: model.category,
          productId: model.firebaseNodeId,
          itemMrp: model.itemMrp,
          firebaseNodeId: node.id,
          totalMrp: model.totalMrp,
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
            .doc(userNodeId)
            .collection("Cart")
            .doc(node.id)
            .update(poducts.toMap());
      });
    } catch (e) {
      print("Adding To Cart Exception - ${e.toString()}");
    }
  }

  updateCart(String userNodeId, String prodInCartId, CartModel model) async {
    try {
      await firebase
          .collection("Users")
          .doc(userNodeId)
          .collection("Cart")
          .doc(prodInCartId)
          .update(model.toMap());
    } catch (e) {
      print("Update Cart Exception - ${e.toString()}");
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getProductsInCart(
      String nodeID) async {
    final data =
        await firebase.collection("Users").doc(nodeID).collection("Cart").get();
    final mapData = data.docs;
    return mapData;
    // print(r);
  }

  removeFromCart(String nodeId, String userNodId) async {
    await firebase
        .collection("Users")
        .doc(userNodId)
        .collection("Cart")
        .doc(nodeId)
        .delete();
  }
  Future<void> clearCart(String userNodId) async {
    final allDocuments = await firebase
        .collection("Users")
        .doc(userNodId)
        .collection("Cart").get();
    for(var item in allDocuments.docs){
      await item.reference.delete();
    }
  }
}
