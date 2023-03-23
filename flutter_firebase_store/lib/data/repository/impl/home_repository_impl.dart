import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_store/domain/model/ModelResponse.dart';
import 'package:flutter_firebase_store/presentation/bloc/home_page/home_page_cubit.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/home_listeners.dart';

import 'dart:async';

import '../../../domain/model/note.dart';
import '../interface/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  CollectionReference users = FirebaseFirestore.instance.collection('notes');
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  FutureOr<ModelResponse>? getNotes({required HomeListeners homeListener }) {
    List<Note>? allNotes;
    try {
      firestoreInstance
          .collection("users")
          .where("ownerUid", isEqualTo: 1)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          allNotes!.add(Note.fromJson(result.data()));
        });
        homeListener.successRetrieved();
        return new ModelResponse(
            error: null,
            data: allNotes,
            message: "Successfully retrieved data");
      });
    } catch (Exception) {
      return new ModelResponse(
          error: null, data: null, message: "Something went wrong");
    }
  }
}
