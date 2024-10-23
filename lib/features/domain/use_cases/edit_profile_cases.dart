import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:rj/features/data/repository/add_address_repository.dart';
import 'package:rj/features/data/repository/add_screen_repository.dart';
import 'package:rj/utils/dependencyLocation.dart';
import 'package:rj/utils/text_controllers.dart';

class EditProfileCases{
  static final editProfileKey = GlobalKey<FormState>();
   validate() {
    if (editProfileKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  static editProfile(UserProfileModel user) async {
  }
}