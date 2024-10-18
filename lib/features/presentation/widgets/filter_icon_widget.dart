import 'package:flutter/material.dart';

import 'filter_bottom_sheet_content.dart';

class FilterIconWidget extends StatelessWidget {
  const FilterIconWidget({
    super.key,
    required this.tag,
    required this.tagContent,
  });

  final String tag;
  final String tagContent;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          //context.read<BottomSheetBloc>().add(CategoryBrandEvent());
          showModalBottomSheet(
              context: context,
              enableDrag: true,
              isDismissible: false,
              builder: (context) =>  FilterBottomSheetContent(
                tag: tag,
                tagName: tagContent,
              ));
        },
        icon: const Icon(Icons.filter_alt_outlined));
  }
}
