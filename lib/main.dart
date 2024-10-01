import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/config/routes/route_names.dart';
import 'package:rj/config/routes/routes.dart';
import 'package:rj/features/presentation/screens/account_screen/bloc/account_bloc.dart';
import 'package:rj/features/presentation/screens/main_screen/bloc/main_bloc.dart';
import 'package:rj/utils/lc.dart';

import 'features/presentation/screens/add_details_screen/bloc/add_details_bloc.dart';
import 'features/presentation/screens/login_screen/bloc/auth_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => MainBloc()),
        BlocProvider(create: (context) => AccountBloc()),
        BlocProvider(create: (context) => AddDetailsBloc()),
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
