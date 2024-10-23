import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:rj/features/data/repository/cart_repository.dart';
import 'package:rj/features/data/repository/contact_us_repository.dart';
import 'package:rj/features/data/repository/explore_repo.dart';
import 'package:rj/features/data/repository/add_screen_repository.dart';
import 'package:rj/features/data/repository/get_firebase_repo.dart';
import 'package:rj/features/data/repository/order_details_repository.dart';
import 'package:rj/features/data/repository/order_list_respository.dart';
import 'package:rj/features/data/repository/product_repository.dart';
import 'package:rj/features/data/repository/wishlist_repository.dart';

import '../features/data/repository/add_address_repository.dart';
import '../features/data/repository/auth_repository.dart';
import '../features/data/repository/filter_repository.dart';
import '../features/data/repository/home_repository.dart';
import '../features/data/repository/search_repository.dart';


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
  locator.registerLazySingleton(()=> WishListRepo());
  locator.registerLazySingleton(()=> OrderListRepo());
  locator.registerLazySingleton(()=> OrderDetailsRepo());
  locator.registerLazySingleton(()=> SearchRepository());
  locator.registerLazySingleton(()=> HomeRepo());
  locator.registerLazySingleton(()=> ContactUsRepo());
}

