import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/models/to_model_class.dart';

import '../models/banner_model.dart';

class HomeRepo {
  Future<BannerModel> getBannerImages() async {
    final data = await FirebaseFirestore.instance
        .collection('Banner')
        .doc("Details")
        .get();
    final dataMap = data.data();
    final lastData = BannerModel(
        bannerImages: dataMap!["bannerImages"], nodeId: dataMap["nodeId"]);
    return lastData;
  }

  Future<List<ProductsModel>> getPriceDropList() async {
    List<ProductsModel> dropList = [];
    final data = await FirebaseFirestore.instance.collection("Products").where("offerPercent",isNotEqualTo: "").get();
    final dataMap = data.docs;
    dropList = dataMap.map((item) {
      return ToModelClass.toProductModel(item);
    }).toList();
    return dropList;
  }
}
