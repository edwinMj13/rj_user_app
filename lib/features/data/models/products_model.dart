class ProductsModel {
  final String itemName;
  final String? images;
  final String category;
  final String? subCategory;
  final String? stock;
  final String description;
  final String brand;
  final String? price;
  final String sellingPrice;

  ProductsModel(
      {required this.itemName,
      this.images,
      required this.category,
      this.subCategory,
      this.stock,
      required this.description,
      required this.brand,
      this.price,
      required this.sellingPrice});
}

List<ProductsModel> productsList = [
  ProductsModel(
      itemName: "Screws 1\'",
      category: "Hardware",
      images: "assets/starscrews.jpg",
      description: "oiuhjndei hebfsehfb jifbjsknfsufbhn jknuisef",
      brand: "Gj",
      sellingPrice: "125"),
  ProductsModel(
      itemName: "Supreme Pipe 110''\'",
      category: "Plumbing",
      images: "assets/supreme_imaeg.jpg",
      description: "oiuhjndei hebfsehfb jifbjsknfsufbhn jknuisef",
      brand: "Supreme",
      sellingPrice: "125"),
  ProductsModel(
      itemName: "Screws 1\'",
      category: "Hardware",
      images: "assets/starscrews.jpg",
      description: "oiuhjndei hebfsehfb jifbjsknfsufbhn jknuisef",
      brand: "Gj",
      sellingPrice: "125"),
  ProductsModel(
      itemName: "Supreme Pipe 110''\'",
      category: "Plumbing",
      images: "assets/supreme_imaeg.jpg",
      description: "oiuhjndei hebfsehfb jifbjsknfsufbhn jknuisef",
      brand: "Supreme",
      sellingPrice: "125"),
];
