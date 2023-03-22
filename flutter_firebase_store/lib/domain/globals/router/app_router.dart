import 'package:flutter/material.dart';
import 'package:flutter_firebase_store/domain/globals/router/router_utils.dart';
import 'package:go_router/go_router.dart';

import '../../../presentation/bloc/screen/auth_page_screen.dart';
import '../provider/app_state_provider.dart';
//Custom files


class AppRouter {
  AppRouter({
    required this.appStateProvider,
  });

  AppStateProvider appStateProvider;
  get router => _router;


  late final _router = GoRouter(
      refreshListenable: appStateProvider,
      initialLocation: "/",
      routes: [

         GoRoute(
            path: APP_PAGE.auth.routePath,
            name: APP_PAGE.auth.routeName,
            builder: (context, state) => const AuthPage(title: "Auth page")
          ),      
      
        GoRoute(
          path: APP_PAGE.home.routePath,
          name: APP_PAGE.home.routeName,
          builder: (context, state) => const AuthPage(title: "Auth page")
        ),
       

        GoRoute(
            path: APP_PAGE.profile.routePath,
            name: APP_PAGE.profile.routeName,
            builder: (context, state) =>  const AuthPage(title: "Auth page")
            ),

        GoRoute(
            path: APP_PAGE.profile_edit.routePath,
            name: APP_PAGE.profile_edit.routeName,
            builder: (context, state) => const AuthPage(title: "Auth page")
            )
          
      ],
      redirect: (state) {
        // define the named path of onboard screen
        final String onboardPath =
            state.namedLocation(APP_PAGE.onboard.routeName);

        // Checking if current path is onboarding or not
        bool isOnboarding = state.subloc == onboardPath;

        if (state.subloc == "/") {
          return null; 
        }


        // returning null will tell router to don't mind redirect section
        return null;
      });
}