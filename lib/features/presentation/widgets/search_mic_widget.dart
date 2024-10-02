import 'package:flutter/material.dart';

class SearchMicWidget extends StatelessWidget {
  SearchMicWidget({
    super.key,
    this.searchCallBack,
    this.micCallBack
  });
  VoidCallback? searchCallBack;
  VoidCallback? micCallBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () =>searchCallBack!(), icon: const Icon(Icons.search)),
        IconButton(
            onPressed: ()=>micCallBack!(),
            icon: const Icon(
              Icons.mic,
            ))
      ],
    );
  }
}
