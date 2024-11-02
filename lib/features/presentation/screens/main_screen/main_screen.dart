import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/config/colors.dart';
import 'package:rj/features/data/data_sources/bottom_navigation_data.dart';
import 'package:rj/features/data/repository/cart_repository.dart';
import 'package:rj/features/domain/use_cases/main_screen_use_cases.dart';
import 'package:rj/features/presentation/screens/main_screen/bloc/main_bloc.dart';
import 'package:rj/features/presentation/screens/main_screen/widgets/main_appbar.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/utils/dependencyLocation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late int cartLength;

  @override
  void initState() {
    // TODO: implement initState
    context
        .read<MainBloc>()
        .add(UpdateIndexCarBadgeEvent(index: 0));

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(ModalRoute.of(context)!.settings.arguments!=null) {
      cartLength =ModalRoute.of(context)!.settings.arguments as int;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:  Size.fromHeight(size.height*0.07),
        child: PopScope(
          canPop: false,
          child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              return FutureBuilder(
                future: CachedData.getUserName(),
                builder: (context, snapshot) {
                  String userName = "";
                  if (snapshot.data != null) {
                    //final stateData = MainScreenIndexBadgeState;
                    if(snapshot.data!.split(' ').length==1){
                      userName = snapshot.data!;
                    }else {
                      userName = snapshot.data!.split(' ').first;
                    }
                    print("userName Account AppBar Name - $userName");
                    return MainAppBar(
                        currentNavIndex: state.index,
                        username: userName);
                  } else {
                    return const SizedBox();
                  }
                },
              );
            },
          ),
        ),
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return mainScreens(state.index);
        },
      ),
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  Widget _bottomNavigation() {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state is MainScreenIndexBadgeState) {
          cartLength = state.cartLength!;
          print("state.cartLength > 0  ${state.cartLength! > 0}\n"
              " state.index == 3 ${state.index == 3}");
          return BottomNavigationBar(
            items: List.generate(
              bottomMenu.length,
                  (index) {
                return BottomNavigationBarItem(
                    icon: bottomMenu[index].title == "Cart" &&
                        state.cartLength! > 0
                        ? Badge(
                      label: Text(cartLength.toString()),
                      backgroundColor: Colors.red,
                      child: Icon(
                        bottomMenu[index].icon,
                      ),
                    )
                        : Icon(bottomMenu[index].icon),
                    label: bottomMenu[index].title);
              },
            ),
            backgroundColor: Colors.black,
            unselectedItemColor: Colors.grey,
            selectedItemColor: primaryColor,
            currentIndex: state.index,
            onTap: (value) =>
                context
                    .read<MainBloc>()
                    .add(UpdateIndexCarBadgeEvent(index: value)),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            showUnselectedLabels: true,
            unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal, color: Colors.grey),
          );
        }else if(state is MainInitial){
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
            currentIndex: state.index,
            onTap: (value) =>
                context
                    .read<MainBloc>()
                    .add(UpdateIndexCarBadgeEvent(index: value)),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            showUnselectedLabels: true,
            unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal, color: Colors.grey),
          );
        }
        return SizedBox();
      },
    );
  }
}
