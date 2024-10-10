import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/domain/use_cases/accounts_screen_usecases.dart';
import 'package:rj/features/presentation/screens/account_screen/widgets/account_card_widgets.dart';
import 'package:rj/features/presentation/screens/account_screen/widgets/icon_text_icon_widget.dart';
import 'package:rj/features/data/data_sources/cached_data.dart';
import 'package:rj/utils/constants.dart';
import 'package:rj/utils/styles.dart';

import '../../../../config/colors.dart';
import '../../../../config/routes/route_names.dart';
import '../../../domain/use_cases/show_loading_case.dart';
import '../../widgets/button_green.dart';
import '../main_screen/bloc/main_bloc.dart';
import 'bloc/account_bloc.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  late BuildContext contextsProgress;

  @override
  Widget build(BuildContext contextMain) {
    contextMain.read<AccountBloc>().add(RecentViewedEvent());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //_greetings(context),
            _accountsCardSection(contextMain),
            IconTextIconWidgets(
                iconStart: CupertinoIcons.person, label: "Edit Profile",callBack: ()=> AccountScreenUsecases.navigateToEditProfileScreen(contextMain),),
            IconTextIconWidgets(
                iconStart: Icons.location_on_outlined, label: "Add Address",callBack: ()=> AccountScreenUsecases.navigateToAddAddressScreen(contextMain),),
            sizedH20,
            BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is RecentItemsSuccessState) {
                  return _recentlyViewedItems(state.listRecent);
                }
                return SizedBox(height: 200,);
              },
            ),
            sizedH20,
            _logoutButtonSection(contextMain),
          ],
        ),
      ),
    );
  }
}

ButtonGreen _logoutButtonSection(BuildContext context) {
  return ButtonGreen(
    label: "Log Out",
    callback: () => showDialogToSignOut(context),
    color: Colors.green,
    backgroundColor: Colors.green[50],);
}

SizedBox _recentlyViewedItems(List<ProductsModel> listRecent) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            "Recently Viewed Items",
            style: style(
                fontSize: 17,
                color: Colors.black,
                weight: FontWeight.normal),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 5, vertical: 15),
                padding: EdgeInsets.all(5),
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 0.1,
                        blurRadius: 5,
                        blurStyle: BlurStyle.normal,
                        offset: Offset(1, 5)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      listRecent[index].mainImage,
                      fit: BoxFit.cover,
                      width: 130,
                      height: 110,
                    ),
                    Text(listRecent[index].itemName),
                  ],
                ),
              );
            },
            itemCount: listRecent.length,
          ),
        ),
      ],
    ),
  );
}


Container _accountsCardSection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(bottom: 20, top: 20),
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AccountCardWidgets(
              iconData: CupertinoIcons.cube_box_fill,
              label: "Orders",
              color: accentListColors[0],
              openScreenCallback:()=>AccountScreenUsecases.navigateToOrdersScreen(context),
            ),
            sizedW20,
            AccountCardWidgets(
              iconData: Icons.favorite_border,
              label: "WishList",
              color: accentListColors[1],
              openScreenCallback:()=>AccountScreenUsecases.navigateToWishListScreen(context),
            ),
          ],
        ),
        sizedH20,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AccountCardWidgets(
              iconData: CupertinoIcons.gift,
              label: "Coupons",
              color: accentListColors[2],
              openScreenCallback:()=>AccountScreenUsecases.navigateToOrdersScreen(context),
            ),
            sizedW20,
            AccountCardWidgets(
              iconData: Icons.call_rounded,
              label: "Contact Us",
              color: accentListColors[3],
              openScreenCallback:()=>AccountScreenUsecases.navigateToOrdersScreen(context),
            ),
          ],
        ),
      ],
    ),
  );
}

void showDialogToSignOut(BuildContext contextMain) {
  showDialog(
      context: contextMain,
      builder: (context) {
        return AlertDialog(
          title: const Text("Alert...!"),
          content: const Text("Are You Sure, You Want To SignOut..."),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
                child: const Text("Yes"),
                onPressed: () {
                  Navigator.pop(context);
                  context.read<AccountBloc>().add(
                      SignOutEvent(context: contextMain));
                }),
          ],
          actionsAlignment: MainAxisAlignment.spaceBetween,
        );
      });
}

