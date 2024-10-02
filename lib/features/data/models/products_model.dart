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
  final String status;
  final List<dynamic> imagesList;

  ProductsModel(
      {required this.itemName,
      required this.category,
      required this.firebaseNodeId,
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
      "mainImage":mainImage,
      "itemBrand":itemBrand,
      "price":price,
      "sellingPrize":sellingPrize
    };
  }
}

List<ProductsModel> productsList = [
  ProductsModel(
    itemName: "Screws 1\'",
    category: "Hardware",
    imagesList: ["assets/starscrews.jpg"],
    description: "oiuhjndei hebfsehfb jifbjsknfsufbhn jknuisef",
    itemBrand: "Gj",
    sellingPrize: "125",
    mainImage: "125",
    firebaseNodeId: '',
    status: '',
  ),
  ProductsModel(
    itemName: "Supreme Pipe 110''\'",
    category: "Plumbing",
    imagesList: ["assets/supreme_imaeg.jpg"],
    description: "oiuhjndei hebfsehfb jifbjsknfsufbhn jknuisef",
    itemBrand: "Supreme",
    mainImage: "125",
    sellingPrize: "125",
    firebaseNodeId: '',
    status: '',
  ),
  ProductsModel(
    itemName: "Screws 1\'",
    category: "Hardware",
    imagesList: ["assets/starscrews.jpg"],
    mainImage: "125",
    description: "oiuhjndei hebfsehfb jifbjsknfsufbhn jknuisef",
    itemBrand: "Gj",
    sellingPrize: "125",
    firebaseNodeId: '',
    status: '',
  ),
  ProductsModel(
    itemName: "Supreme Pipe 110''\'",
    category: "Plumbing",
    imagesList: ["assets/supreme_imaeg.jpg"],
    description: "oiuhjndei hebfsehfb jifbjsknfsufbhn jknuisef",
    itemBrand: "Supreme",
    mainImage: "125",
    sellingPrize: "125",
    firebaseNodeId: '',
    status: '',
  ),
];
