import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroke_text/stroke_text.dart';

import '../../../../../utils/constants.dart';
import '../../../../domain/use_cases/common_use_cases.dart';
import '../../../../domain/use_cases/home_use_cases.dart';
import '../bloc/home_bloc.dart';

class PriceDropwidget extends StatelessWidget {
  const PriceDropwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        print("Home State ${state.runtimeType}");
        if (state is FetchDataHomeSuccessState) {
          return Container(
            color: Colors.yellowAccent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Price Dropped",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height:180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final model = state.priceDropList[index];
                      final discountPercent =
                      HomeUseCases.getDiscountPercent(model);
                      print(discountPercent);

                      return Container(
                        height: 120,
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border:
                          Border.all(width: 0.5, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Center(
                                child: Image.network(
                                  model.mainImage!,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child,
                                      loadingProgress) =>
                                      CommonUseCases
                                          .checkIfImageLoadingPRODUCTPlaceholder(
                                          loadingProgress, child, 120),
                                )),
                            Positioned(
                              right: 0,
                              left: 0,
                              bottom: 0,
                              child: Container(
                                  child: StrokeText(
                                    text: "${discountPercent.toInt().toString()}%",
                                    textStyle: const TextStyle(
                                        color: Colors.greenAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 60),
                                    strokeColor: Colors.yellowAccent,
                                    strokeWidth: 6,
                                  )),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: state.priceDropList.length,
                  ),
                ),
                sizedH20,
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
