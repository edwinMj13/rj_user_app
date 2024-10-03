import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rj/features/data/models/storage_image_model.dart';

snackbar(BuildContext context, String s) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
}

ValueNotifier<Map<String, dynamic>> sliderNotifier = ValueNotifier({});

updateSlider(double start, double end) {
  Map<String, dynamic> data = {
    "start": start,
    "end": end,
  };
  sliderNotifier.value = data;
}

List<StorageImageModel> getImageList(List<dynamic> state) {
  return state
      .map((e) => StorageImageModel(
            storageRefPath: e["storageRefPath"],
            downloadUrl: e["downloadUrl"],
          ))
      .toList();
}
