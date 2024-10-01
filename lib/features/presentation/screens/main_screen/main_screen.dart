import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/config/colors.dart';
import 'package:rj/config/routes/route_names.dart';
import 'package:rj/features/data/data_sources/bottom_navigation_data.dart';
import 'package:rj/features/presentation/screens/main_screen/widgets/main_screen_appbar.dart';
import 'package:rj/features/services/main_services.dart';
import 'package:rj/utils/cached_data.dart';
import 'package:rj/utils/common.dart';
import 'package:rj/utils/constants.dart';
import 'package:rj/utils/lc.dart';

import '../../../../utils/styles.dart';
import '../../../data/repository/auth_repository.dart';
import 'bloc/main_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentNavIndex = 0;
  late final String? userName;
  MainServices mainServices = MainServices();

  updateIndex(int index) {
    setState(() {
      currentNavIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainServices.getUser();
    userName = mainServices.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(preferredSize: Size.fromHeight(60),
      child: MainScreenAppBar(currentNavIndex:currentNavIndex,username:userName!)),
      body: homeScreens[currentNavIndex],
      bottomNavigationBar: _bottomNavigation(),
    );
  }


  BottomNavigationBar _bottomNavigation() {
    return BottomNavigationBar(
      items: List.generate(
        bottomMenu.length,
        (index) {
          return BottomNavigationBarItem(
              icon: Icon(bottomMenu[index].icon),
              label: bottomMenu[index].title);
        },
      ),
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.grey,
      selectedItemColor: primaryColor,
      currentIndex: currentNavIndex,
      onTap: updateIndex,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      showUnselectedLabels: true,
      unselectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
    );
  }
}

