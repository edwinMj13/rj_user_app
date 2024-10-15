import 'package:rj/features/data/models/cart_model.dart';

class ToModelClass {
  static CartModel toCartModel(e){
    return CartModel(
      itemName: e["itemName"],
      category: e["category"],
      firebaseNodeId: e["firebaseNodeId"],
      productId: e["productId"],
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
    );
  }
}