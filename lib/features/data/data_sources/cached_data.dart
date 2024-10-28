import 'package:rj/features/data/models/user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/screens/login_screen/bloc/auth_bloc.dart';

class CachedData {
  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _nodeId;
  String? _uid;
  String? _shippingAddress;
  String? _pincode;

  String? get name => _name;

  String? get email => _email;

  String? get phoneNumber => _phoneNumber;

  String? get nodeId => _nodeId;

  String? get uid => _uid;

  String? get shippingAddress => _shippingAddress;

  String? get pincode => _pincode;
  static addProfileData(AuthSuccessState authSuccessSTate) async {
    final sharedPref = await SharedPreferences.getInstance();

    await sharedPref.setString('name', authSuccessSTate.user.displayName?? "");
    await sharedPref.setString('email', authSuccessSTate.user.email?? "");
    await sharedPref.setString(
        'phoneNumber', authSuccessSTate.user.phoneNumber ?? "");
    await sharedPref.setString('uid', authSuccessSTate.user.uid);
    await sharedPref.setBool(
        'emailVerified', authSuccessSTate.user.emailVerified);
    await sharedPref.setBool('isLogged', true);
    print("displayName : ${sharedPref.getString("name")?? ""}\n"
        "email : ${sharedPref.getString("email")?? ""}\n"
        "phoneNumber : ${sharedPref.getString("phoneNumber")?? ""}\n"
        "uid : ${sharedPref.getString("uid")?? ""}\n"
        "emailVerified : ${sharedPref.getBool("emailVerified")}\n");
  }

  static saveUserNode(String nodeId,String shipping,String pincode,String phoneNumber) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('nodeId', nodeId);
    await sharedPref.setString('shippingAddress', shipping);
    await sharedPref.setString('phoneNumber', phoneNumber);
    await sharedPref.setString('pincode', pincode);
  }

  static dynamic getDataFromSharedPref(String tag) async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.get(tag);
  }

  static clearSharedPrefData() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.clear();
  }

  static Future<String> getUserName() async {
    final sharedPref = await SharedPreferences.getInstance();
    print(sharedPref.getString("name")!);
    String value = sharedPref.getString("name")!;
    return value;
  }

  static Future<UserProfileModel> getUserDetails() async {
    final sharedPref = await SharedPreferences.getInstance();
    final user = UserProfileModel(
      name: sharedPref.getString("name") ?? "",
      phoneNumber: sharedPref.getString("phoneNumber") ?? "",
      email: sharedPref.getString("email") ?? "",
      nodeID: sharedPref.getString("nodeId") ?? "",
      uid: sharedPref.getString("uid") ?? "",
      shippingAddress: sharedPref.getString("shippingAddress") ?? "",
      pincode: sharedPref.getString("pincode") ?? "",
    );
    return user;
  }

  getSetUser() async {
    final sharedPref = await SharedPreferences.getInstance();
    _name = sharedPref.getString("name")!;
    _phoneNumber = sharedPref.getString("phoneNumber")!;
    _email = sharedPref.getString("email")!;
    _nodeId = sharedPref.getString("nodeId")!;
    _uid = sharedPref.getString("uid")!;
    _shippingAddress = sharedPref.getString("shippingAddress")!;
    _pincode = sharedPref.getString("pincode")!;
    //print(_billingAddress);
  }

  static setLoggedIn(bool isLoggedIn) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool("isLoggedIn", isLoggedIn);
  }
  static Future<bool> getLoggedIn() async {
    final sharedPref = await SharedPreferences.getInstance();
    final status = sharedPref.getBool("isLoggedIn")?? false;
    return status;
  }
}
