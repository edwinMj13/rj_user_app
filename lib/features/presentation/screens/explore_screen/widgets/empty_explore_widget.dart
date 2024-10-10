import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../utils/styles.dart';
import '../../../widgets/nothing_text_widget.dart';

class EmptyExploreWidget extends StatelessWidget {
  const EmptyExploreWidget({
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
              child: Icon(Icons.dataset_outlined,size: 100,color: Colors.grey,),
            ),
          ),
          NothingTextWidget()
        ],
      ),
    );
  }
}

