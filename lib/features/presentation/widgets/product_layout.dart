import 'package:flutter/material.dart';
import 'package:rj/features/data/models/products_model.dart';

import '../../../utils/constants.dart';
import '../../../utils/styles.dart';
import '../../data/models/storage_image_model.dart';
import '../../domain/use_cases/explore_page_usecase.dart';
import '../screens/explore_screen/bloc/explore_bloc.dart';

class ProductLayout extends StatelessWidget {
   ProductLayout({
    super.key,
    required this.productsModel,
  });

  final ProductsModel productsModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ExplorePageUseCase.navigateToDetails(context,productsModel),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width: 0.5,color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(productsModel.mainImage,height: 120,fit: BoxFit.cover,)),
            Text(productsModel.itemName,style: style(fontSize: 15, color:Colors.black, weight: FontWeight.bold),),
            Text(
              productsModel.description, maxLines: 1,),
            Text("$rupeeSymbol ${productsModel.sellingPrize}",style: style(fontSize: 14, color:Colors.black, weight: FontWeight.bold)),
          ],),
      ),
    );
  }
}
