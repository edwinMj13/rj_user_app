import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonUseCases {

  static Widget checkIfImageLoadingCATEGORYPlaceholder(ImageChunkEvent? loadingProgress, Widget child) {
    if(loadingProgress == null) return child;
    return const Icon(Icons.category);
  }
  static Widget checkIfImageLoadingPRODUCTPlaceholder(ImageChunkEvent? loadingProgress, Widget child, double size) {
    if(loadingProgress == null) return child;
    return Icon(CupertinoIcons.cube,size: size,color: Colors.grey,);
  }
}