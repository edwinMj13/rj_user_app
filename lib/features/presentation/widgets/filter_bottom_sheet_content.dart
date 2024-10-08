import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/domain/use_cases/filter_get_use_cases.dart';
import 'package:rj/features/presentation/screens/category_details_screen/bloc/category_details_bloc.dart';
import 'package:rj/features/presentation/widgets/button_green.dart';
import 'package:rj/features/presentation/widgets/slide_up_animation_widget.dart';
import 'package:rj/features/presentation/widgets/slider_design.dart';
import 'package:rj/utils/constants.dart';

import '../../../utils/common.dart';
import '../screens/explore_screen/bloc/explore_bloc.dart';
import 'blocs/bottom_sheet/category_brand_bottomsheet_bloc/bottom_sheet_bloc.dart';
import 'drop_down_button.dart';

class FilterBottomSheetContent extends StatefulWidget {
  String tag;
  FilterBottomSheetContent({super.key, required this.tag});

  @override
  State<FilterBottomSheetContent> createState() =>
      _FilterBottomSheetContentState();
}

class _FilterBottomSheetContentState extends State<FilterBottomSheetContent>
    with SingleTickerProviderStateMixin {
  String? selectedItem;
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
    return Container(
      width: double.infinity,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          _closeButton(context),
          sizedH30,
          SlideUPAnimatedWidget(
            childWidget: _brand_Category(),
            animationController: animationController,
          ),
          sizedH30,
          SlideUPAnimatedWidget(
            animationController: animationController,
            childWidget: DropDownButtonWidget(
              label: 'Sub-Category',
              dataList: context
                  .watch<BottomSheetBloc>()
                  .subCategories,
            ),
          ),
          sizedH20,
          SlideUPAnimatedWidget(
            animationController: animationController,
            childWidget: SliderDesign(),
          ),
          sizedH30,
          SlideUPAnimatedWidget(animationController: animationController,
              childWidget: __actionButton()),
        ],
      ),
    );
  }

  IconButton _closeButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
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
            callback: () => Navigator.of(context).pop(),
            color: Colors.green),
        ButtonGreen(
            backgroundColor: Colors.green,
            label: "Show Results",
            callback: () => callback(),
            color: Colors.white),
      ],
    );
  }

  BlocBuilder<BottomSheetBloc, BottomSheetState> _brand_Category() {
    return BlocBuilder<BottomSheetBloc, BottomSheetState>(
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
        return const SizedBox();
      },
    );
  }

  void callback() {
    final sub = context
        .read<BottomSheetBloc>()
        .subCategoryString;
    final bran = context
        .read<BottomSheetBloc>()
        .brand;
    final cate = context
        .read<BottomSheetBloc>()
        .category;
    print("bran - $bran   sub - $sub   cate - $cate");
    if(widget.tag=="ExP") {
      context.read<ExploreBloc>().add(ProductsFetchFilterEvent(
        brand: bran!,
        category: cate!,
        subCategory: sub!,
        sliderStart: sliderStart!,
        context: context,
        sliderEnd: sliderEnd!,));
    }else{
      context.read<CategoryDetailsBloc>().add(CategoryFetchFilterEvent(
        brand: bran!,
        category: cate!,
        subCategory: sub!,
        sliderStart: sliderStart!,
        context: context,
        sliderEnd: sliderEnd!,));
    }
  }
}
