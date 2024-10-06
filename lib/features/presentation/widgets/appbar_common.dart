import 'package:flutter/material.dart';
import 'package:rj/features/presentation/widgets/search_mic_widget.dart';

class AppbarCommon extends StatelessWidget {
  const AppbarCommon({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back)),
          SearchMicWidget(),
        ],
      ),
    );
  }
}
