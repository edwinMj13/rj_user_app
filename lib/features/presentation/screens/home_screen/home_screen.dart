import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/config/colors.dart';
import 'package:rj/features/data/models/category_model.dart';
import 'package:rj/features/domain/use_cases/home_use_cases.dart';
import 'package:rj/features/presentation/screens/home_screen/widgets/categories_list_widget.dart';
import 'package:rj/utils/constants.dart';
import 'package:rj/utils/styles.dart';
import 'package:shimmer/shimmer.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(FetchDataHomeEvent());
    return Container(
      child: Column(
        children: [_topChips(), sizedH10, _banner(), _contents()],
      ),
    );
  }

  Widget _contents() {
    return SizedBox(
      height: 120,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is FetchDataHomeSuccessState) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.categoryList.length,
              itemBuilder: (context, index) {
                return CategoryItemsWidget(categoryList: state.categoryList[index],index:index,);
              },
            );
          }
          return const SizedBox();
        },
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Chip(label: Text("Latest Arrivals")),
        Chip(label: Text("Top Offers")),
        Chip(label: Text("Price Dropped")),
      ],
    );
  }
}

