import 'dart:async';

import 'package:flutter_firebase_store/data/repository/interface/auth_repository.dart';
import 'package:flutter_firebase_store/domain/model/user.dart';
import 'package:flutter_firebase_store/domain/model/ModelResponse.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/auth_registration_listeners.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  FutureOr<ModelResponse>? registerUser(
      {required User user,
      required AuthRegistrationListener authRegistrationListener}) async {
    try {
      await users.add(user.toJson()).then((value) {
        print("User Added");
        authRegistrationListener.successRegister();
        return new ModelResponse(
            error: null,
            data: user,
            message: "User was successfully registered");
      }).catchError((error) {
        print("Failed to add user: $error");
        return new ModelResponse(
            error: error, data: user, message: "Something went wrong");
      });
      return new ModelResponse(
          error: null, data: user, message: "Something went wrong");
    } catch (e) {
      print(e);
      return new ModelResponse(
          error: null, data: user, message: "Something went wrong");
    }
  }

  @override
  FutureOr<ModelResponse>? authUser(
      {required User user,
      required AuthRegistrationListener authRegistrationListener}) async {

          final SharedPreferences prefs = await SharedPreferences.getInstance();

    try  {
      firestoreInstance
          .collection("users")
          .where("email", isEqualTo: user.email)
          .get(GetOptions())
          .then((value) async {
        var retreivedUser = User.fromJson(value.docs[0].data());
        
        if (retreivedUser == null) {
          authRegistrationListener.userNotFound();
          return new ModelResponse(
            error: "", data: user, message: "User not found");
        }
        
        if (retreivedUser.password != user.password) {
           authRegistrationListener.wrongPassword();
          return new ModelResponse(
            error: "", data: user, message: "Wrong password");
        }
        
        print(retreivedUser.userName);

        await prefs.setString('uid', value.docs[0].id);

        authRegistrationListener.successLogin();
        value.docs.forEach((result) {
          print(result.data());
        });
      }).catchError((error) {
        print("Failed to auth user: $error");
        return new ModelResponse(
            error: error, data: user, message: "Something went wrong");
      });

      return new ModelResponse(
          error: null, data: user, message: "Something went wrong");
    } catch (e) {
      print(e);
      return new ModelResponse(
          error: null, data: user, message: "Something went wrong");
    }
  }
}
