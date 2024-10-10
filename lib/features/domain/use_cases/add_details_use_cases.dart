import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/config/routes/route_names.dart';

import '../../../utils/text_controllers.dart';
import '../../data/models/user_profile_model.dart';
import '../../presentation/screens/add_details_screen/bloc/add_details_bloc.dart';
import '../../presentation/screens/home_screen/bloc/home_bloc.dart';

class AddDetailsUseCases{

  final formKeyAddDetails = GlobalKey<FormState>();
  static setTextFields(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final argumentsUser =
      ModalRoute.of(context)?.settings.arguments as UserProfileModel;
      nameAddAddressController.text = argumentsUser.name;
      phoneAddAddressController.text = argumentsUser.phoneNumber;
      emailAddAddressController.text = argumentsUser.email;
    }
  }

  validate() {
    final isValidted = formKeyAddDetails.currentState!.validate();
    if (isValidted) {
      return true;
    } else {
      return false;
    }
  }

  addAddress(BuildContext context, UserProfileModel model) async {
    if (validate()) {
      print("${model.name}");
      context.read<AddDetailsBloc>().add(UploadUserDetailsEvent(
          userDetail: model, callback: () => navigateToNext(context)));
    }
  }

  navigateToNext(BuildContext context) {
    context.read<HomeBloc>().add(FetchDataHomeEvent());

    Navigator.pushNamed(context, RouteNames.mainScreen);
  }

}