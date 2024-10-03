import 'package:flutter/material.dart';
import 'package:rj/features/data/models/user_profile_model.dart';

import '../../../utils/cached_data.dart';
import '../../../utils/constants.dart';
import '../../../utils/styles.dart';
import 'button_green.dart';

class AddressChangeWidget extends StatelessWidget {
  final VoidCallback callback;
  final UserProfileModel userModal;
  AddressChangeWidget({super.key,required this.callback,required this.userModal});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userModal.name,
              style: style(
                  fontSize: 18,
                  color: Colors.black,
                  weight: FontWeight.bold),
            ),
            Text(userModal.shippingAddress!)
          ],
        ),
        ButtonGreen(
            backgroundColor: Colors.white,
            label: "Change",
            callback: () => callback(),
            color: Colors.blue)
      ],
    );
  }
}
