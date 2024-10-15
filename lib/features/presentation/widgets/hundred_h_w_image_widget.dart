
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../domain/use_cases/common_use_cases.dart';

class HundredHWImageWidget extends StatelessWidget {
  const HundredHWImageWidget({
    super.key,
    required this.mainImage,
  });
  final String mainImage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          mainImage,
          height: 100.0,
          width: 100.0,
          loadingBuilder: (context, child, loadingProgress) =>
              CommonUseCases.checkIfImageLoadingPRODUCTPlaceholder(
                  loadingProgress, child, 100),
        ),
        sizedH10,
      ],
    );
  }
}