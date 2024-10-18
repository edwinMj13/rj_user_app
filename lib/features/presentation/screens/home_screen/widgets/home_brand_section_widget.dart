import 'package:flutter/material.dart';
import 'package:rj/features/domain/use_cases/home_use_cases.dart';

import '../../../../../utils/constants.dart';
import '../../../../data/models/brand_model.dart';
import '../../../../domain/use_cases/common_use_cases.dart';

class HomeBrandSectionWidget extends StatelessWidget {
  const HomeBrandSectionWidget({
    super.key,
    required this.brandList,
  });

  final List<BrandModel> brandList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            topBrands,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
          ),
          SizedBox(
            height: 300,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: brandList.length,
              itemBuilder: (context, index) {
                return _brandItem(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  InkWell _brandItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        HomeUseCases.navigateToBrandDetailsScreen(
            context, brandList[index]);
      },
      child: Stack(
        children: [
          Image.network(
            brandList[index].image,
            height: 150,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) =>
                CommonUseCases.checkIfImageLoadingPRODUCTPlaceholder(
                    loadingProgress, child, 150),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: halfOpacityGray,
              ),
              child: Center(
                child: Text(
                  brandList[index].name,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
