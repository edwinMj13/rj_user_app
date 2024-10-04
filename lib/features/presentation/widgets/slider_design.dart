import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/utils/common.dart';
import 'package:rj/utils/constants.dart';

import '../../../utils/styles.dart';

class SliderDesign extends StatelessWidget {


  SliderDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: sliderNotifier,
      builder: (context,data,_){
        double startVal = data["start"] ?? 0.0;
        double endVal = data["end"] ?? 5000.0;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("Price Range",style: style(fontSize: 14,weight: FontWeight.normal,color: Colors.black),),
              _rangeSider(startVal, endVal),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$rupeeSymbol ${startVal.toInt().toString()}"),
                  Text("$rupeeSymbol ${endVal.toInt().toString()}"),
                ],
              ),
            ],
          );
      },
    );
  }

  RangeSlider _rangeSider(double startVal, double endVal) {
    return RangeSlider(
              min: 0,
              max: 20000,
              values: RangeValues(startVal, endVal),
              onChanged: (val) {
                updateSlider(val.start,val.end);
              },
            );
  }
}
