import 'package:flutter/material.dart';

import '../../../../../utils/common.dart';
import '../../../../../utils/styles.dart';

class MainScreenAppBar extends StatelessWidget {
  final int currentNavIndex;
  final String username;
  const MainScreenAppBar({
    super.key,
    required this.currentNavIndex,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: _getContent(),

      actions: [
        PopupMenuButton(
          menuPadding: EdgeInsets.zero,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Text('About'),
            ),
          ],
          onSelected: (value) {
            if (value == 1) {
              snackbar(context, "About");
            }
          },
        )
      ],
    );
  }
  _getContent() {
    switch(currentNavIndex){
      case 0:
        return ;
      case 1:
        return ;
      case 2:
        return _greetings();
      case 3:
        return const Text("Cart");
    }
    return currentNavIndex == 2 ? _greetings() : const Text("RJ");
  }
  Widget _greetings() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
              text: "Hi, ",
              style: style(
                  fontSize: 30, color: Colors.black, weight: FontWeight.normal),
              children: [
                TextSpan(
                    text: username,
                    style: style(
                      fontSize: 30,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    )),
              ]),
        ),
        const SizedBox(),
      ],
    );
  }

}
