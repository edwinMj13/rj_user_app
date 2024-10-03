import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/domain/use_cases/filter_get_use_cases.dart';
import 'package:rj/features/presentation/widgets/button_green.dart';
import 'package:rj/features/presentation/widgets/slider_design.dart';
import 'package:rj/utils/constants.dart';

import 'blocs/bottom_sheet/category_brand_bottomsheet_bloc/bottom_sheet_bloc.dart';
import 'drop_down_button.dart';

class FilterBottomSheetContent extends StatefulWidget {
  FilterBottomSheetContent({super.key});

  @override
  State<FilterBottomSheetContent> createState() =>
      _FilterBottomSheetContentState();
}

class _FilterBottomSheetContentState extends State<FilterBottomSheetContent> {
  String? selectedItem;
  List<String> brandList = [];
  List<String> categoryList = [];

  @override
  void initState() {
    // TODO: implement initState
    context.read<BottomSheetBloc>().add(CategoryBrandEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.keyboard_arrow_down_outlined)),
          sizedH30,
          BlocBuilder<BottomSheetBloc, BottomSheetState>(
            builder: (context, state) {
              if (state is CategoryBrandSuccessState) {
                print(state.categoryList);
                return Row(
                  children: [
                    Expanded(
                      child: DropDownButtonWidget(
                        label: "Brand",
                        dataList: state.brandList,
                      ),
                    ),
                    sizedW10,
                    Expanded(
                      child: DropDownButtonWidget(
                        label: 'Category',
                        dataList: state.categoryList,
                      ),
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
          sizedH30,
          DropDownButtonWidget(
            label: 'Sub-Category',
          ),
          sizedH20,
          SliderDesign(),
          sizedH30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonGreen(
                  backgroundColor: Colors.green[50],
                  label: "Cancel",
                  callback: callback,
                  color: Colors.green),
              ButtonGreen(
                  backgroundColor: Colors.green,
                  label: "Show Results",
                  callback: callback,
                  color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  void callback() {}
}
