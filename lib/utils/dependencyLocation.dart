import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:rj/features/data/repository/cart_repository.dart';
import 'package:rj/features/data/repository/explore_repo.dart';
import 'package:rj/features/data/repository/add_screen_repository.dart';
import 'package:rj/features/data/repository/get_firebase_repo.dart';
import 'package:rj/features/data/repository/product_repository.dart';

import '../features/data/repository/add_address_repository.dart';
import '../features/data/repository/auth_repository.dart';
import '../features/data/repository/filter_repository.dart';


final locator =GetIt.instance;

Future<void> initializeDependencies()async {

  //  registerLazySingleton() -- loaded only when it is used and will be deleted when it is not in use.

  locator.registerLazySingleton(()=> AuthRepository());
  locator.registerLazySingleton(()=> AddScreenRepo());
  locator.registerLazySingleton(()=> CartRepository());
  locator.registerLazySingleton(()=> ExploreRepo());
  locator.registerLazySingleton(()=> GetFromFirebaseRepository());
  locator.registerLazySingleton(()=> ProductRepo());
  locator.registerLazySingleton(()=> FilterRepo());
  locator.registerLazySingleton(()=> AddAddressRepo());

}
