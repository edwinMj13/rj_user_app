import 'package:cloud_firestore/cloud_firestore.dart';

import '../data_sources/cached_data.dart';
import '../models/user_profile_model.dart';

class AddScreenRepo {
  final firebase = FirebaseFirestore.instance;

  Future<void> addUser(UserProfileModel userProfile) async {
    CollectionReference users = firebase.collection('Users');
    await users.add(userProfile.toMap()).then((value) {
      final model = UserProfileModel(
        nodeID: value.id,
        name: userProfile.name,
        phoneNumber: userProfile.phoneNumber,
        email: userProfile.email,
        uid: userProfile.uid,
        shippingAddress: userProfile.shippingAddress,
        billingAddress: userProfile.billingAddress,
      );
      CachedData.saveUserNode(value.id,userProfile.shippingAddress!,userProfile.billingAddress!);
      firebase.collection("Users").doc(value.id).update(model.toMap());
      //print("User Added Success - ${value}");
    }).catchError((e) {
      print("USser Added Catch Error - ${e.toString()}");
    });
  }
}
