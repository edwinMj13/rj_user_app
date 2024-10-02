import 'package:shared_preferences/shared_preferences.dart';

import '../features/presentation/screens/login_screen/bloc/auth_bloc.dart';

class CachedData{

  static String name="";

  static addProfileData(AuthSuccessState authSuccessSTate) async {
    final sharedPref= await SharedPreferences.getInstance();

    await sharedPref.setString('name', authSuccessSTate.user.displayName!);
    await sharedPref.setString('email', authSuccessSTate.user.email!);
    await sharedPref.setString('phoneNumber', authSuccessSTate.user.phoneNumber??"");
    await sharedPref.setString('uid', authSuccessSTate.user.uid);
    await sharedPref.setBool('emailVerified', authSuccessSTate.user.emailVerified);
    await sharedPref.setBool('isLogged', true);
    print("displayName : ${sharedPref.getString("name")!}\n"
        "email : ${sharedPref.getString("email")!}\n"
        "phoneNumber : ${sharedPref.getString("phoneNumber")!}\n"
        "uid : ${sharedPref.getString("uid")!}\n"
        "emailVerified : ${sharedPref.getBool("emailVerified")}\n");
    name =  sharedPref.getString("name")!;

  }

  static dynamic getDataFromSharedPref(String tag) async {
    final sharedPref= await SharedPreferences.getInstance();
    return sharedPref.get(tag);
  }

  static clearSharedPrefData() async {
    final sharedPref= await SharedPreferences.getInstance();
    sharedPref.clear();
  }

  static Future<String> getUserName() async {
    final sharedPref= await SharedPreferences.getInstance();
    print(sharedPref.getString("name")!);
    String value=sharedPref.getString("name")!;
    return value;
  }

}