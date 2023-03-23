import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_store/domain/model/ModelResponse.dart';

import 'dart:async';

import '../interface/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  CollectionReference users = FirebaseFirestore.instance.collection('notes');
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  FutureOr<ModelResponse>? getNotes() {
    // TODO: implement getNotes
    throw UnimplementedError();
  }

}