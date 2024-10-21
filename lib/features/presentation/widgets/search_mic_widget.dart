import 'package:flutter/material.dart';

import '../../domain/use_cases/main_screen_use_cases.dart';

class SearchMicWidget extends StatelessWidget {
  SearchMicWidget({
    super.key,
    this.micCallBack
  });
  VoidCallback? micCallBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () =>MainScreenUseCases.navigateToSearchScreen(context), icon: const Icon(Icons.search)),
        IconButton(
            onPressed: ()=>micCallBack!(),
            icon: const Icon(
              Icons.mic,
            ))
      ],
    );
  }
}
