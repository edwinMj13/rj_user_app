import 'package:flutter/material.dart';
import 'package:rj/features/domain/use_cases/common_use_cases.dart';

import '../../../../../config/colors.dart';
import '../../../../../utils/styles.dart';
import '../../../../data/models/category_model.dart';
import '../../../../domain/use_cases/home_use_cases.dart';

class CategoryItemsWidget extends StatelessWidget {
  final CategoryModel categoryList;
  final int index;

  const CategoryItemsWidget({
    super.key,
    required this.categoryList,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height*0.1;
    return InkWell(
      onTap: () => HomeUseCases.navigateToCategoryDetailsScreen(
          context, categoryList.categoryName),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height,
              width: height,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: colorsNormalCategoryList[index][200],
                borderRadius: BorderRadius.circular(100),
              ),
              child: Image.network(
                categoryList.image,
                loadingBuilder: (context,child,loadingProgress){
                  return CommonUseCases.checkIfImageLoadingCATEGORYPlaceholder(loadingProgress, child);
                },
              ),
            ),
            Text(
              categoryList.categoryName,
              style: style(
                  fontSize: 12, color: Colors.black, weight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }


}
