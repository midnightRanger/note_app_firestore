import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_store/data/repository/impl/auth_repository_impl.dart';
import 'package:flutter_firebase_store/data/repository/interface/auth_repository.dart';
import 'package:flutter_firebase_store/domain/use_cases/impl/auth_case_impl.dart';
import 'package:flutter_firebase_store/firebase_options.dart';
import 'package:flutter_firebase_store/presentation/bloc/auth_page/auth_page_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'DI.dart';
import 'domain/globals/provider/app_state_provider.dart';
import 'domain/globals/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                AuthPageCubit(AuthCaseImpl(AuthRepositoryImpl()))),

        // Remove previous Provider call and create new proxyprovider that depends on AppStateProvider
        ChangeNotifierProvider(create: (context) => AppStateProvider()),
        ProxyProvider<AppStateProvider, AppRouter>(
            update: (context, appStateProvider, _) =>
                AppRouter(appStateProvider: appStateProvider))
      ],
      child: FutureBuilder(
          future: DI.getInstance().init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final GoRouter router = Provider.of<AppRouter>(context).router;

              return MaterialApp.router(
                  routeInformationParser: router.routeInformationParser,
                  //theme: mainTheme,
                  routerDelegate: router.routerDelegate);
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
