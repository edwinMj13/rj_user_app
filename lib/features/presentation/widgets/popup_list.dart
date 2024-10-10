
import 'package:flutter/material.dart';

import '../../../utils/styles.dart';

class PopupDialogSelectList extends StatelessWidget {
  final List<String> list;
  final Function(String) callBack;
  const PopupDialogSelectList({super.key,required this.list,required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(list.length, (index){
          return InkWell(
            onTap: (){
              callBack(list[index]);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Center(
                child: Text(
                  list[index],
                  style: style(
                      fontSize: 15,
                      color: Colors.black,
                      weight: FontWeight.normal),
                ),
              ),
            ),
          );
        }),
      )
    );
  }
}
