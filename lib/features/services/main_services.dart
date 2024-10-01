import '../../utils/cached_data.dart';

class MainServices{

  String? _userName;
  String? get userName => _userName;

  getUser() async {
    final user = await CachedData.getUserName();
    _userName = user.split(' ').first;
  }
}