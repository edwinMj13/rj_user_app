import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../utils/styles.dart';
import '../../../widgets/nothing_text_widget.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              child: SvgPicture.asset(
                "assets/empty_icons/cart-cross-svgrepo-com.svg",
                width: 150,
                height: 150,

              ),
            ),
          ),
          const NothingTextWidget(),
        ],
      ),
    );
  }
}
