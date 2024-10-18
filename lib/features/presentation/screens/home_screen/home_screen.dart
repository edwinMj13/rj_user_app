import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/config/colors.dart';
import 'package:rj/features/data/models/brand_model.dart';
import 'package:rj/features/data/models/category_model.dart';
import 'package:rj/features/domain/use_cases/home_use_cases.dart';
import 'package:rj/features/presentation/screens/home_screen/widgets/categories_list_widget.dart';
import 'package:rj/features/presentation/screens/home_screen/widgets/home_brand_section_widget.dart';
import 'package:rj/utils/constants.dart';
import 'package:rj/utils/styles.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/use_cases/common_use_cases.dart';
import 'bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topChips(),
            sizedH10,
            _banner(),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                print("Home State ${state.runtimeType}");
                if (state is FetchDataHomeSuccessState) {
                  return HomeCategoryWidget(
                    categoryList: state.categoryList,
                  );
                }
                return SizedBox();
              },
            ),

            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                print("Home State ${state.runtimeType}");
                if (state is FetchDataHomeSuccessState) {
                  return HomeBrandSectionWidget(brandList:state.brandList);
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  CarouselSlider _banner() {
    return CarouselSlider(
      items: [
        Image.asset("assets/dummy_banner.jpg"),
        Image.asset("assets/dummy_banner.jpg"),
        Image.asset("assets/dummy_banner.jpg"),
      ],
      options: CarouselOptions(autoPlay: true, viewportFraction: 1),
    );
  }

  Row _topChips() {
    print("Explore Screen");
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Chip(label: Text("Latest Arrivals")),
        Chip(label: Text("Popular")),
        Chip(label: Text("Price Dropped")),
      ],
    );
  }
}


class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({
    super.key,
    required this.categoryList,
  });

  final List<CategoryModel> categoryList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return CategoryItemsWidget(
            categoryList: categoryList[index],
            index: index,
          );
        },
      ),
    );
  }
}
