import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/config/routes/route_names.dart';
import 'package:rj/config/routes/routes.dart';
import 'package:rj/features/data/repository/auth_repository.dart';
import 'package:rj/features/presentation/screens/account_screen/bloc/account_bloc.dart';
import 'package:rj/features/presentation/screens/add_address_screen/bloc/add_address_screen_bloc.dart';
import 'package:rj/features/presentation/screens/brand_details_screen/bloc/brand_details_bloc.dart';
import 'package:rj/features/presentation/screens/cart_screen/bloc/cart_bloc.dart';
import 'package:rj/features/presentation/screens/change_address_screen/bloc/change_address_bloc.dart';
import 'package:rj/features/presentation/screens/explore_screen/bloc/explore_bloc.dart';
import 'package:rj/features/presentation/screens/home_screen/bloc/home_bloc.dart';
import 'package:rj/features/presentation/screens/main_screen/bloc/main_bloc.dart';
import 'package:rj/features/presentation/screens/order_details_screen/bloc/order_details_bloc.dart';
import 'package:rj/features/presentation/screens/order_list_screen/bloc/order_list_bloc.dart';
import 'package:rj/features/presentation/screens/place_order_screen/address_bloc/address_bloc.dart';
import 'package:rj/features/presentation/screens/product_details/bloc/product_details_bloc.dart';
import 'package:rj/features/presentation/screens/search_screen/bloc/search_bloc.dart';
import 'package:rj/utils/dependencyLocation.dart';

import 'features/presentation/screens/add_details_screen/bloc/add_details_bloc.dart';
import 'features/presentation/screens/category_details_screen/bloc/category_details_bloc.dart';
import 'features/presentation/screens/login_screen/bloc/auth_bloc.dart';
import 'features/presentation/screens/place_order_screen/bloc/place_order_bloc.dart';
import 'features/presentation/screens/wish_list_screen/bloc/wish_list_bloc.dart';
import 'features/presentation/widgets/blocs/bottom_sheet/category_brand_bottomsheet_bloc/bottom_sheet_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(authRepository: locator<AuthRepository>())),
        BlocProvider(create: (context) => MainBloc()),
        BlocProvider(create: (context) => AccountBloc()),
        BlocProvider(create: (context) => AddDetailsBloc()),
        BlocProvider(create: (context) => ExploreBloc()),
        BlocProvider(create: (context) => BottomSheetBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => ProductDetailsBloc()),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => CategoryDetailsBloc()),
        BlocProvider(create: (context) => AddAddressScreenBloc()),
        BlocProvider(create: (context) => WishListBloc()),
        BlocProvider(create: (context) => ChangeAddressBloc()),
        BlocProvider(create: (context) => PlaceOrderBloc()),
        BlocProvider(create: (context) => AddressBloc()),
        BlocProvider(create: (context) => OrderListBloc()),
        BlocProvider(create: (context) => OrderDetailsBloc()),
        BlocProvider(create: (context) => BrandDetailsBloc()),
        BlocProvider(create: (context) => SearchBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RouteNames.splashScreen,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
