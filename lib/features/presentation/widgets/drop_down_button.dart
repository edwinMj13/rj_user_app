import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/domain/use_cases/filter_get_use_cases.dart';
import 'package:rj/features/presentation/widgets/blocs/bottom_sheet/category_brand_bottomsheet_bloc/bottom_sheet_bloc.dart';


class DropDownButtonWidget extends StatelessWidget {
  DropDownButtonWidget({
    super.key,
    required this.label,
    this.dataList,
  });

  String? selectedItem;
  String? selectedSubItem;
  final String label;
  List<String>? dataList;
  FilterGetDataUseCase filterGetDataUseCase = FilterGetDataUseCase();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return label != "Sub-Category"
        ? _ifBrandOrCategory(context)
        : _ifSubCategory(context);
  }

  DropdownButtonFormField<String> _ifBrandOrCategory(BuildContext context) {
    return DropdownButtonFormField(
      value: selectedItem,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(label),
      ),
      items: dataList!.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e),
        );
      }).toList(),
      onChanged: (value) {
        selectedItem = value!;
        //if (label == "Category") {
          context
              .read<BottomSheetBloc>()
              .add(SubCategorySheetEvent(selectedItem: selectedItem!,tag: label));
        // } else if (label == "Brand") {
        //   context
        //       .read<BottomSheetBloc>()
        //       .add(SubCategorySheetEvent(selectedItem: selectedItem!));
        // }
      },
    );
  }

  _ifSubCategory(BuildContext context) {
    return dataList != null
        ? DropdownButtonFormField(
            value: selectedSubItem,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text(label),
            ),
            items: dataList!.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (value) {
              selectedSubItem = value;
              context
                  .read<BottomSheetBloc>()
                  .add(SubCategorySheetEvent(selectedItem: value!,tag: label));
            },
          )
        : DropdownButtonFormField(
            value: selectedSubItem,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: Text(label!),
            ),
            items: const [
              DropdownMenuItem(
                value: "child",
                child: Text("child"),
              ),
            ],
            onChanged: null,
          );
  }
}

List<String> qw = ["qwer", "efrsd", "eefdsfds"];
