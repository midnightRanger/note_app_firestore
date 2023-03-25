import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_store/data/repository/interface/profile_repository.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/profile_edit_listeners.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/profile_listeners.dart';
import 'package:flutter_firebase_store/domain/model/user.dart';
import 'package:flutter_firebase_store/presentation/bloc/profile_page/profile_page_cubit.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final firestoreInstance = FirebaseFirestore.instance;
  @override
  FutureOr<User?> getUser(
      {required String uid, required ProfileListeners profileListeners}) {
    try {
      firestoreInstance.collection("users").doc(uid).get().then((value) {
        profileListeners.successRetrieved();
        profileListeners.user(User.fromJson(value.data()!));
      });
    } catch (Exception) {
      print(Exception);
    }

    return null;
  }

  @override
  FutureOr<User?> getUserForUpdate(
      {required String uid, required ProfileEditListeners profileListeners}) {
    try {
      firestoreInstance.collection("users").doc(uid).get().then((value) {
        profileListeners.successRetrieved();
        profileListeners.user(User.fromJson(value.data()!));
      });
    } catch (Exception) {
      print(Exception);
    }

    return null;
  }

  @override
  FutureOr<User?> updateUser(
      {required String uid,
      required ProfileEditListeners profileEditListeners,
      required User? user}) async {
    try {
      firestoreInstance.collection("users").doc(uid).update({
        "email": "${user!.email}",
        "password": "${user.password}",
        "userName": "${user.userName}"
      }).then((value) {
        profileEditListeners.user(user);
        profileEditListeners.successUpdated(user);
      });
    } catch (Exception) {
      print(Exception);
    }

      return user; 
  }
}
