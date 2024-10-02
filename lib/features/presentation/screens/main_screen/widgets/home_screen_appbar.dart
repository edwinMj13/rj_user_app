import 'package:flutter/material.dart';
import 'package:rj/utils/constants.dart';

import '../../../../../utils/text_controllers.dart';

class HomeScreenAppbar extends StatelessWidget {
  const HomeScreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Row(
        children: [
          const Text("RJ"),
          sizedW20,
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.only(left: 4.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextField(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
