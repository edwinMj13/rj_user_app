import 'package:flutter/material.dart';
import 'package:rj/config/colors.dart';
import 'package:rj/features/data/data_sources/bottom_navigation_data.dart';
import 'package:rj/features/domain/use_cases/main_screen_use_cases.dart';
import 'package:rj/features/presentation/screens/main_screen/widgets/main_appbar.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentNavIndex = 0;
  CachedData cachedData = CachedData();

  updateIndex(int index) {
    setState(() {
      currentNavIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    cachedData.getSetUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Future<String>? myFuture = CachedData.getUserName();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child:
        FutureBuilder<String>(
          future: CachedData.getUserName(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return MainAppBar(
                  currentNavIndex: currentNavIndex,
                  username: snapshot.data!.split(' ').first);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
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
