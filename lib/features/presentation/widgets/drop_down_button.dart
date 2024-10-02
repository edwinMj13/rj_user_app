import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/repository/filter_get_data.dart';

import 'blocs/bottom_sheet/sub_category_bottomsheet_bloc/sub_categoey_bottomsheet_bloc.dart';

class DropDownButtonWidget extends StatelessWidget {
  DropDownButtonWidget({
    super.key,
    required this.label,
    this.dataList,
  });

  String? selectedItem;
  String? selectedSubItem;
  final String? label;
  List<String>? dataList;
  FilterGetData filterGetData = FilterGetData();

  @override
  Widget build(BuildContext context) {
    return label != "Sub-Category"
        ? DropdownButtonFormField(
      value: selectedItem,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text(label!),
      ),
      items: dataList!.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e),
        );
      }).toList(),
      onChanged: (value) {
        selectedItem = value!;
        if (label == "Category") {
          context.read<SubCategoeyBottomsheetBloc>().add(SubCateSheetEvent(selectedItem: selectedItem!));
        }
      },
    )
        : BlocBuilder<SubCategoeyBottomsheetBloc, SubCategoeyBottomsheetState>(
      builder: (context, state) {
        if(state is SubCategoeyBottomsheetSuccessState){
          return DropdownButtonFormField(
            value: selectedSubItem,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text(label!),
            ),
            items: state.subList.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (value) {
              selectedSubItem = value!;
              selectedSubItem=null;
            },
          );
        }
        return DropdownButtonFormField(
          value: selectedSubItem,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text(label!),
          ),
          items: const [DropdownMenuItem(value: "child",child: Text("child"),)],
          onChanged: null,
        );
      },
    );
    SizedBox();
  }
}

List<String> qw = ["qwer", "efrsd", "eefdsfds"];
