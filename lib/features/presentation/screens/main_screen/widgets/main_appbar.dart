import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/presentation/screens/main_screen/widgets/home_screen_appbar.dart';
import 'package:rj/features/presentation/screens/main_screen/widgets/explore_screen_appbar.dart';

import '../../../../../utils/common.dart';
import '../../../../../utils/styles.dart';
import '../../account_screen/bloc/account_bloc.dart';

class MainAppBar extends StatelessWidget {
  final int currentNavIndex;
  final String username;

  const MainAppBar({
    super.key,
    required this.currentNavIndex,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: _selectContent(),
      /* actions: [
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
      ],*/
    );
  }

  _selectContent() {
    switch (currentNavIndex) {
      case 0:
        return  HomeScreenAppbar();
      case 1:
        return const ExploreScreenAppBar();
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
      ],
    );
  }

}
