import 'package:flutter/material.dart';

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
    return InkWell(
      onTap: ()=> HomeUseCases.navigateToCategoryDetailsScreen(context,categoryList.categoryName),
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 70,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: accentListColors[index].shade100,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Image.network(
                categoryList.image,
              ),
            ),
            Text(
              categoryList.categoryName,
              style: style(
                  fontSize: 13,
                  color: Colors.black,
                  weight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
