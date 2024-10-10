import 'package:flutter/material.dart';
import 'package:rj/features/presentation/screens/account_screen/account_screen.dart';
import 'package:rj/features/presentation/screens/cart_screen/cart_screen.dart';
import 'package:rj/features/presentation/screens/explore_screen/explore_screen.dart';

import '../../presentation/screens/home_screen/home_screen.dart';

class BottomNavData {
  final String title;
  final IconData icon;

  BottomNavData({required this.title, required this.icon});
}

List<BottomNavData> bottomMenu = [
  BottomNavData(title: "Home", icon: Icons.home),
  BottomNavData(title: "Explore", icon: Icons.explore),
  BottomNavData(title: "Account", icon: Icons.person),
  BottomNavData(title: "Cart", icon: Icons.shopping_cart),
];

Widget mainScreens(int index) {
  //print(index);
  switch (index) {
    case 0:
      return HomeScreen();
    case 1:
      return ExploreScreen();
    case 2:
      return AccountScreen();
    case 3:
      return CartScreen();
    default :
      return SizedBox();
  }
}
