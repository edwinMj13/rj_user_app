import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/config/colors.dart';
import 'package:rj/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(FetchDataHomeEvent());
    return Container(
      child: Column(
        children: [
          _topChips(),
        sizedH10,
          _banner(),
          _contents()
        ],
      ),
    );
  }

  Expanded _contents() {
    return Expanded(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if(state is FetchDataHomeSuccessState){
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5, vertical: 5),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categoryList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: SizedBox(
                              height: 70,
                              width: 70,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: accentListColors[index],
                                child: Image.network(state.categoryList[index].image,fit: BoxFit.fill,),
                              ),
                            ),
                          ),
                          Text(state.categoryList[index].categoryName),
                        ],
                      ),
                    );
                  },
                );
              }
              return SizedBox();
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
          options: CarouselOptions(
            autoPlay: true,
              viewportFraction: 1
          ),
        );
  }

  Row _topChips() {
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
