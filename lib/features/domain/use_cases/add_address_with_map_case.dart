import 'package:flutter/cupertino.dart';
import 'package:rj/features/data/models/address_model.dart';
import 'package:rj/features/data/repository/add_address_repository.dart';
import 'package:rj/utils/dependencyLocation.dart';

import '../../../utils/text_controllers.dart';

class AddAddressWithMapCase{

  final addAddressWIthMapKey = GlobalKey<FormState>();

  validate(){
    final isValidated = addAddressWIthMapKey.currentState!.validate();
    if(isValidated){
      return true;
    }
    return false;
  }
  addAddress(AddressModel model, String userNodeId,BuildContext context) async {
   await locator<AddAddressRepo>().uploadAddress(model, userNodeId).then((_){
     addMapAddressNameController.clear();
   addMapAddressAddressController.clear();
   addMapAddressPincodeController.clear();
   });
  }
}