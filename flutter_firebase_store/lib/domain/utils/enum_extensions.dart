import 'package:flutter_firebase_store/presentation/bloc/auth_page/auth_page_state.dart';

import '../../presentation/bloc/auth_page/auth_page_cubit.dart';

extension AuthPageExtension on AuthUserState {
  String get getNotificationMessage {
    switch (this) {
      case AuthUserState.failed: 
        return "Oops... Something went wrong."; 
      case AuthUserState.initial: 
        return "Initial";
      case AuthUserState.successLogin: 
        return "Sucessfully logged in!"; 
      case AuthUserState.successRegister: 
        return "Successfully registered!";
      case AuthUserState.userNotFound: 
        return "User with following data not found"; 
      case AuthUserState.user_exists: 
        return "User already exist!";
      case AuthUserState.weak_password: 
        return "Password is too weak!";
      case AuthUserState.wrongPassword: 
        return "Sorry, wrong password!"; 
    }
  } 
}