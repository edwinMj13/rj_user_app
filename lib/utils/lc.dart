import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:rj/features/data/repository/firebse_methods.dart';

import '../features/data/repository/auth_repository.dart';


final locator =GetIt.instance;

Future<void> initializeDependencies()async {
  locator.registerLazySingleton(()=> AuthRepository());
  locator.registerLazySingleton(()=> FirebaseMethods());
}
