import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/domain/use_cases/filter_get_use_cases.dart';
import 'package:rj/features/presentation/screens/category_details_screen/bloc/category_details_bloc.dart';
import 'package:rj/features/presentation/widgets/button_green.dart';
import 'package:rj/features/presentation/widgets/popup_list.dart';
import 'package:rj/features/presentation/widgets/slide_up_animation_widget.dart';
import 'package:rj/features/presentation/widgets/slider_design.dart';
import 'package:rj/utils/constants.dart';

import '../../../utils/common.dart';
import '../screens/explore_screen/bloc/explore_bloc.dart';
import 'blocs/bottom_sheet/category_brand_bottomsheet_bloc/bottom_sheet_bloc.dart';
import 'filter_select_listenable_widget.dart';

class FilterBottomSheetContent extends StatefulWidget {
  final String tag;
  final String tagName;

  const FilterBottomSheetContent({
    super.key,
    required this.tag,
    required this.tagName,
  });

  @override
  State<FilterBottomSheetContent> createState() =>
      _FilterBottomSheetContentState();
}

class _FilterBottomSheetContentState extends State<FilterBottomSheetContent>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    print(widget.tag);
    // TODO: implement initState
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    Timer(
        const Duration(milliseconds: 200), () => animationController.forward());
    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: FilterGetDataUseCase.hasError,
        builder: (context, snap, _) {
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: snap == true ? Colors.red : Colors.white,
                width: 1,
              ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                _closeButton(context),
                sizedH30,
                SlideUPAnimatedWidget(
                  childWidget: _brandCategory(),
                  animationController: animationController,
                ),
                sizedH30,
                SlideUPAnimatedWidget(
                  animationController: animationController,
                  childWidget: _filterSelectSubcategoryListenable(),
                ),
                sizedH20,
                SlideUPAnimatedWidget(
                  animationController: animationController,
                  childWidget: SliderDesign(),
                ),
                snap == true
                    ? const SizedBox(
                        height: 30, child: Text(selectAllFieldsText))
                    : sizedH30,
                SlideUPAnimatedWidget(
                    animationController: animationController,
                    childWidget: __actionButton()),
              ],
            ),
          );
        });
  }

  ValueListenableBuilder<List<String>> _filterSelectSubcategoryListenable() {
    return ValueListenableBuilder<List<String>>(
        valueListenable: FilterGetDataUseCase.subCategoryListNotifier,
        builder: (context, snap, _) {
          print("Sub_List Notifier $snap");
          return FilterSelectListenableWidget(
            list: snap,
            label: "Sub-Category",
            valueListenable: FilterGetDataUseCase.subCategoryNotifier,
          );
        });
  }

  IconButton _closeButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          FilterGetDataUseCase.clearFields(context);
        },
        icon: const Icon(Icons.keyboard_arrow_down_outlined));
  }

  Row __actionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonGreen(
            backgroundColor: Colors.green[50],
            label: "Cancel",
            callback: () => FilterGetDataUseCase.clearFields(context),
            color: Colors.green),
        ButtonGreen(
            backgroundColor: Colors.green,
            label: "Show Results",
            callback: () =>
                FilterGetDataUseCase.showFilterResults(widget.tag, context),
            color: Colors.white),
      ],
    );
  }

  _brandCategory() {
    return Row(
      children: [
        Expanded(
          child: FilterSelectListenableWidget(
            label: "Brand",
            tagName:widget.tagName,
            fromScreen:widget.tag,
            valueListenable: FilterGetDataUseCase.brandNotifier,
          ),
        ),
        sizedW20,
        Expanded(
          child: FilterSelectListenableWidget(
            label: "Category",
            tagName:widget.tagName,
            fromScreen:widget.tag,
            valueListenable: FilterGetDataUseCase.categoryNotifier,
          ),
        ),
      ],
    );
  }
}
