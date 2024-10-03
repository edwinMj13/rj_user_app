class ProductsModel {
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
  final List<dynamic> imagesList;

  ProductsModel(
      {required this.itemName,
      required this.category,
      required this.firebaseNodeId,
      required this.productId,
      required this.status,
      required this.imagesList,
      this.subCategory,
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
      "description":description,
      "productId":productId,
      "mainImage":mainImage,
      "itemBrand":itemBrand,
      "price":price,
      "sellingPrize":sellingPrize
    };
  }
}
