import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/styles.dart';
import '../../data/models/storage_image_model.dart';
import '../screens/explore_screen/bloc/explore_bloc.dart';

class ProductLayout extends StatelessWidget {
   ProductLayout({
    super.key,
    required this.width,
    required this.imageUrl,
    required this.stateData,
    required this.index,
  });

  final double width;
  final String imageUrl;
  final ProductsSuccessExploreState stateData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width*0.40,
      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 0.5,color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.network(imageUrl,height: 120,fit: BoxFit.cover,)),
          Text(stateData.productList[index].itemName,style: style(fontSize: 15, color:Colors.black, weight: FontWeight.bold),),
          Text(
            stateData.productList[index].description, maxLines: 1,),
          Text("$rupeeSymbol ${stateData.productList[index].sellingPrize}",style: style(fontSize: 14, color:Colors.black, weight: FontWeight.bold)),
        ],),
    );
  }
}
