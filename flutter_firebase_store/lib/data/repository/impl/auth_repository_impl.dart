import 'package:flutter_firebase_store/data/repository/interface/auth_repository.dart';
import 'package:flutter_firebase_store/domain/model/user.dart';
import 'package:flutter_firebase_store/domain/model/ModelResponse.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepositoryImpl extends AuthRepository {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  ModelResponse? registerUser(User user) {
    users.add(user.toJson()).then((value) {
      print("User Added");
      return new ModelResponse(
          error: null, data: user, message: "User was successfully registered");
    }).catchError((error) {
      print("Failed to add user: $error");
      return new ModelResponse(
          error: error, data: user, message: "Something went wrong");
    });
  }
}
