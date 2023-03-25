import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_store/data/repository/interface/note_repository.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/note_add_listeners.dart';
import 'package:flutter_firebase_store/domain/model/note.dart';
import 'package:flutter_firebase_store/domain/model/ModelResponse.dart';

class NoteRepositoryImpl extends NoteRepository {
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  FutureOr<Note?> addNote (
      {required String uid, required Note note, required NoteAddListeners noteAddListeners}) async {
    try {
      
     await firestoreInstance.collection("note").add (
        note.toJson()
      ).then ((value) {
        noteAddListeners.successCreated();
      });
    } catch (e) {
      print(e);
    }

    return note; 
  }
}
