import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/styles.dart';
import 'nothing_text_widget.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
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
              child: const Icon(
                CupertinoIcons.layers,
                color: Colors.grey,
                size: 100,
              ),
            ),
          ),
          const NothingTextWidget(),
        ],
      ),
    );
  }
}
