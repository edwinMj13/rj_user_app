import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/models/storage_image_model.dart';

class ExploreRepo {
  final firebase = FirebaseFirestore.instance;

  Future<List<ProductsModel>> getAllProducts() async {
    List<ProductsModel> productList = [];
    try {
      final data = await firebase.collection("Products").get();
      final dataDocs = data.docs;
      productList = dataDocs.map((model) {
        return ProductsModel(
          itemName: model["itemName"],
          category: model["category"],
          firebaseNodeId: model["firebaseNodeId"],
          itemMrp: model["itemMrp"],
          productId: model["firebaseNodeId"],
          totalMrp: model["totalMrp"],
          status: model["status"],
          imagesList: model["imagesList"],
          description: model["description"],
          mainImage: model["mainImage"],
          itemBrand: model["itemBrand"],
          sellingPrize: model["sellingPrize"],
          price: model["price"],
          stock: model["stock"],
          subCategory: model["subCategory"],
        );
      }).toList();
      print("DATAAA $productList");
    } catch (e) {
      print("Products Read Exception ${e.toString()}");
    }
    return productList;
  }


}
