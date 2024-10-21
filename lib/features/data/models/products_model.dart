import 'package:flutter/material.dart';
import 'package:rj/features/data/models/storage_image_model.dart';

class ProductsModel {

  final String firebaseNodeId;
  final String itemName;
  final String itemBrand;
  final String category;
  final String? subCategory;
  final String price;
  final String itemMrp;
  final String sellingPrize;
  final String offerPercent;
  final String offerAmount;
  final String stock;
  final String status;
  final String description;
  final String productId;
  final String itemAddedDate;
  final String? mainImage;
  final List<dynamic> imagesList;

  ProductsModel({
    required this.firebaseNodeId,
    required this.imagesList,
    required this.itemName,
    required this.category,
    required this.itemBrand,
    required this.itemAddedDate,
    this.subCategory,
    required this.itemMrp,
    required this.price,
    required this.sellingPrize,
    required this.productId,
    this.mainImage,
    required this.stock,
    required this.offerPercent,
    required this.offerAmount,
     required this.status,
    required this.description,
  });


  Map<String, dynamic> toMap(){
    return {
      "firebaseNodeId":firebaseNodeId,
      "itemName":itemName,
      "category":category,
      "subCategory":subCategory,
      "price":price,
      "itemMrp":itemMrp,
      "sellingPrize":sellingPrize,
      "itemAddedDate":itemAddedDate,
      "offerPercent":offerPercent,
      "offerAmount":offerAmount,
      "mainImage":mainImage,
      "status":status,
      "itemBrand":itemBrand,
      "productId":productId,
      "stock":stock,
      "description":description,
      "imagesList":imagesList,
    };
  }
}



List<String> productsTableTitle=[
  "Image",
  "Product Name",
  "Category",
  "Price",
  "Sale Price",
  "Stock",
  "Status",
  "Actions",
];







/*
List<ProductTableDataModel> productTableData = [
  ProductTableDataModel("8138qw", Icons.notifications, "Cellar Calling Bell", "Home Appliances", "Alarms",
      200, 180, 259, "Available", 'A Calling bell suitable for many thing'),
  ProductTableDataModel("8138qw", Icons.notifications, "Cellar Calling Bell", "Home Appliances", "Alarms",
      200, 180, 259, "Available", 'A Calling bell suitable for many thing'),
  ProductTableDataModel("8138qw", Icons.notifications, "Cellar Calling Bell", "Home Appliances", "Alarms",
      200, 180, 259, "Available", 'A Calling bell suitable for many thing'),
  ProductTableDataModel("8138qw", Icons.notifications, "Cellar Calling Bell", "Home Appliances", "Alarms",
      200, 180, 259, "Available", 'A Calling bell suitable for many thing'),
  ProductTableDataModel("8138qw", Icons.notifications, "Cellar Calling Bell", "Home Appliances", "Alarms",
      200, 180, 259, "Available", 'A Calling bell suitable for many thing'),
];

*/

