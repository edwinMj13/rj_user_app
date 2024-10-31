import 'package:flutter/material.dart';
import 'package:rj/features/domain/use_cases/main_screen_use_cases.dart';
import 'package:rj/utils/common.dart';
import 'package:rj/utils/constants.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../../utils/text_controllers.dart';

class HomeScreenAppbar extends StatefulWidget {
   HomeScreenAppbar({super.key});

  @override
  State<HomeScreenAppbar> createState() => _HomeScreenAppbarState();
}

class _HomeScreenAppbarState extends State<HomeScreenAppbar> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Row(
        children: [
          const Text("RJ"),
          sizedW20,
          Expanded(
            child: InkWell(
              onTap: ()=>MainScreenUseCases.navigateToSearchScreen(context),
              child: Container(
                height: 40,
                padding: const EdgeInsets.only(left: 4.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Row(
                    children: [
                      Icon(Icons.search,),
                      sizedW10,
                      Text(search,style: TextStyle(color: Colors.grey,fontSize: 16),),
                    ],
                  ),
                  Icon(Icons.mic,),
                ],),
                /*TextField(
                  controller: searchAppBarController,
                  //onChanged: searchBar,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search,),
                    suffixIcon: IconButton(
                        onPressed: () {

                        },
                        icon:  Icon(Icons.mic,)),
                  ),
                ),*/
              ),
            ),
          ),
        ],
      ),
    );
  }



}
