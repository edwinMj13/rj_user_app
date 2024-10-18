import 'package:rj/features/data/models/cart_model.dart';
import 'package:rj/features/data/models/order_cart_purchase_model.dart';
import 'package:rj/features/data/models/products_model.dart';

class ToModelClass {
  static OrderCartPurchaseModel toPurchaseModel(item){
    return OrderCartPurchaseModel(
      itemName: item["itemName"],
      itemCategory: item["itemCategory"],
      itemFirebaseNodeId: item["itemFirebaseNodeId"],
      itemProductId: item["itemProductId"],
      itemStatus: item["itemStatus"],
      itemMrp: item["itemMrp"],
      imagesList: item["imagesList"],
      itemCartedQuantity: item["itemCartedQuantity"],
      itemPrice: item["itemPrice"],
      itemSubCategory: item["itemSubCategory"],
      itemCartedLastAmt: item["itemCartedLastAmt"],
      itemDiscountAmt: item["itemDiscountAmt"],
      itemDiscountPercent: item["itemDiscountPercent"],
      itemDescription: item["itemDescription"],
      itemBrand: item["itemBrand"],
      itemMainImage: item["itemMainImage"],
      itemSellingPrize: item["itemSellingPrize"],
    );
  }
  static ProductsModel toProductModel(model){
    print(model["itemName"]);
    return ProductsModel(
      itemName: model["itemName"],
      category: model["category"],
      firebaseNodeId: model["firebaseNodeId"],
      itemMrp: model["itemMrp"],
      productId: model["productId"],
      //totalMrp: model["totalMrp"],
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
  }
}