import 'package:flutter/material.dart';

import '../../utils/text_controllers.dart';
import '../data/models/user_profile_model.dart';

class AddDetailsServices {
  static setTextFields(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final argumentsUser =
          ModalRoute.of(context)?.settings.arguments as UserProfileModel;
      nameAddAddressController.text = argumentsUser.name;
      phoneAddAddressController.text = argumentsUser.phoneNumber;
      emailAddAddressController.text = argumentsUser.email;
    }
  }
}
