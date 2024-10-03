import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/presentation/screens/account_screen/widgets/account_card_widgets.dart';
import 'package:rj/features/presentation/screens/account_screen/widgets/icon_text_icon_widget.dart';
import 'package:rj/features/services/accounts_screen_services.dart';
import 'package:rj/features/services/show_loading_services.dart';
import 'package:rj/utils/cached_data.dart';
import 'package:rj/utils/constants.dart';
import 'package:rj/utils/styles.dart';

import '../../../../config/colors.dart';
import '../../../../config/routes/route_names.dart';
import '../../widgets/button_green.dart';
import '../main_screen/bloc/main_bloc.dart';
import 'bloc/account_bloc.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  late BuildContext contextsProgress;
  AccountsScreenServices accountsScreenServices=AccountsScreenServices();
  LoadingServices loadingServices = LoadingServices();

  @override
  Widget build(BuildContext context) {
    context.read<AccountBloc>().add(RecentViewedEvent());
    return BlocBuilder<AccountBloc, AccountState>(
  builder: (context, state) {
    if(state is RecentItemsSuccessState) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //_greetings(context),
              _accountsCardSection(),
              const IconTextIconWidgets(
                  iconStart: CupertinoIcons.person, label: "Edit Profile"),
              const IconTextIconWidgets(
                  iconStart: Icons.location_on_outlined, label: "Edit Address"),
              sizedH20,
              _recentlyViewedItems(state.listRecent),
              sizedH20,
              ButtonGreen(label: "Log Out",
                callback: () => showDialogToSignOut(context),
                color: Colors.green,
                backgroundColor: Colors.green[50],),
            ],
          ),
        ),
      );
    }
    return SizedBox();
  },
);
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


  Container _accountsCardSection() {
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
              ),
              sizedW20,
              AccountCardWidgets(
                iconData: Icons.favorite_border,
                label: "WishList",
                color: accentListColors[1],
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
              ),
              sizedW20,
              AccountCardWidgets(
                iconData: Icons.call_rounded,
                label: "Contact Us",
                color: accentListColors[3],
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
                    loadingServices.showLoading(context,"Loading...");
                    context.read<AccountBloc>().add(
                        SignOutEvent(() => accountsScreenServices.signOutToLoginScreen(contextMain,()=>loadingServices.cancelLoading())));
                  }),
            ],
            actionsAlignment: MainAxisAlignment.spaceBetween,
          );
        });
  }

}
