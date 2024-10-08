import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rj/features/data/models/storage_image_model.dart';

snackbar(BuildContext context, String s) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
}

ValueNotifier<Map<String, dynamic>> sliderNotifier = ValueNotifier({});
double? _sliderStart=0.0;
double? get sliderStart => _sliderStart;
double? _sliderEnd=5000.0;
double? get sliderEnd => _sliderEnd;
updateSlider(double start, double end) {
  Map<String, dynamic> data = {
    "start": start,
    "end": end,
  };
  _sliderStart=start;
  _sliderEnd=end;
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
