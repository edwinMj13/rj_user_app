import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/presentation/widgets/popup_list.dart';
import 'package:rj/utils/styles.dart';

import '../../domain/use_cases/filter_get_use_cases.dart';
import 'blocs/bottom_sheet/category_brand_bottomsheet_bloc/bottom_sheet_bloc.dart';

class FilterSelectListenableWidget extends StatelessWidget {
  FilterSelectListenableWidget({
    super.key,
    this.list,
    required this.label,
    required this.valueListenable,
  });

  final String label;
  final ValueListenable<String> valueListenable;
  final List<String>? list;
  List<String> listTwo = [];
  FilterGetDataUseCase filterGetDataUseCase = FilterGetDataUseCase();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
        valueListenable: valueListenable,
        builder: (context, snap, _) {
          final selectedValue = snap ?? "Select";
          print("snap $selectedValue");

          return InkWell(
            onTap: () async {
              if (label == "Category") {
                listTwo = await filterGetDataUseCase.getCategoryNames();
              } else if (label == "Brand") {
                listTwo = await filterGetDataUseCase.getBrands();
              }
              print("LISTTTT $list");
              if(label=="Sub-Category" && list!.isEmpty){

              }else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return PopupDialogSelectList(
                        list: _getListToPopup(),
                        callBack: (selectedValue) {
                          FilterGetDataUseCase.selectFromPopupDialog(
                              selectedValue, context, label);
                        },
                      );
                    });
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      snap,
                      style: style(
                          fontSize: 17,
                          color: Colors.black,
                          weight: FontWeight.normal),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  List<String> _getListToPopup() => label == "Sub-Category" ? list! : listTwo;
}
