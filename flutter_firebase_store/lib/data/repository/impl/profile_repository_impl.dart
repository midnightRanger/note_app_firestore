import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_store/data/repository/interface/profile_repository.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/profile_listeners.dart';
import 'package:flutter_firebase_store/domain/model/user.dart';
import 'package:flutter_firebase_store/presentation/bloc/profile_page/profile_page_cubit.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final firestoreInstance = FirebaseFirestore.instance;
  @override
  FutureOr<User?> getUser({required String uid, required ProfileListeners profileListeners}) {
    try {
         firestoreInstance
        .collection("users")
        .doc(uid)
        .get().then((value) {
      
        profileListeners.successRetrieved();
        profileListeners.user(User.fromJson(value.data()!));
        
    });
    } catch (Exception) {
      print(Exception); 
    }

    return null; 
  }

}