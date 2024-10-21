import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/models/to_model_class.dart';

class WishListRepo {
  final firebase = FirebaseFirestore.instance;

  Future<void> addToWishList(String userNodeId, ProductsModel model) async {
    await firebase
        .collection("Users")
        .doc(userNodeId)
        .collection("wishlist")
        .add(model.toMap())
        .then((node) async {
      final product = ProductsModel(
        itemName: model.itemName,
        itemMrp: model.itemMrp,
        category: model.category,
        firebaseNodeId: node.id,
        productId: model.productId,
        //totalMrp: model.totalMrp,
        subCategory: model.subCategory,
        stock: model.stock,
        price: model.price,
        offerAmount: model.offerAmount,
        offerPercent: model.offerPercent,
        itemAddedDate: model.itemAddedDate,
        status: model.status,
        imagesList: model.imagesList,
        description: model.description,
        itemBrand: model.itemBrand,
        mainImage: model.mainImage,
        sellingPrize: model.sellingPrize,
      );
      await firebase
          .collection("Users")
          .doc(userNodeId)
          .collection("wishlist")
          .doc(node.id)
          .update(product.toMap());
    });
  }

  Future<List<ProductsModel>> getWIshListProducts(String userNodeId) async {
    final data = await firebase
        .collection("Users")
        .doc(userNodeId)
        .collection("wishlist")
        .get();
    final dataMap = data.docs;

    final wishList = dataMap
        .map((e) => ToModelClass.toProductModel(e))
        .toList();
    return wishList;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getWIshListProductsToCheck(String userNodeId) async {
    final data = await firebase
        .collection("Users")
        .doc(userNodeId)
        .collection("wishlist")
        .get();
    final dataMap = data.docs;
    print("Check $data");
    return dataMap;
  }

  Future<void> deleteFromWishList(String userNode,String nodeId) async {
    await firebase
        .collection("Users")
        .doc(userNode)
        .collection("wishlist").doc(nodeId).delete();
  }

}
