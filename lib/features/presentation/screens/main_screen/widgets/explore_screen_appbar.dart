import 'package:flutter/material.dart';
import 'package:rj/utils/constants.dart';

import '../../../../../utils/text_controllers.dart';
import '../../../widgets/search_mic_widget.dart';

class ExploreScreenAppBar extends StatelessWidget {
  const ExploreScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Explore"),
          SearchMicWidget(),
        ],
      ),
    );
  }
}

