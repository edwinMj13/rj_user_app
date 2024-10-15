class CartModel {
  final String itemName;
  final String category;
  final String? subCategory;
  final String? stock;
  final String mainImage;
  final String description;
  final String itemBrand;
  final String? price;
  final String sellingPrize;
  final String firebaseNodeId;
  final String productId;
  final String status;
  final int cartedQuantity;
  final int totalAmount;
  final List<dynamic> imagesList;

  CartModel(
      {required this.itemName,
        required this.category,
        required this.firebaseNodeId,
        required this.productId,
        required this.status,
        required this.imagesList,
        this.subCategory,
        required this.cartedQuantity,
        required this.totalAmount,
        this.stock,
        required this.description,
        required this.itemBrand,
        required this.mainImage,
        this.price,
        required this.sellingPrize});


  Map<String, dynamic> toMap(){
    return {
      "itemName":itemName,
      "category":category,
      "firebaseNodeId":firebaseNodeId,
      "status":status,
      "imagesList":imagesList,
      "subCategory":subCategory,
      "stock":stock,
      "cartedQuantity":cartedQuantity,
      "totalAmount":totalAmount,
      "description":description,
      "productId":productId,
      "mainImage":mainImage,
      "itemBrand":itemBrand,
      "price":price,
      "sellingPrize":sellingPrize
    };
  }
  /*CartModel toModel (e){
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
  }*/
}
