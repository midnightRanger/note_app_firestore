import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_store/data/repository/interface/note_repository.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/home_listeners.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/note_add_listeners.dart';
import 'package:flutter_firebase_store/domain/model/note.dart';
import 'package:flutter_firebase_store/domain/model/ModelResponse.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/note_update_listeners.dart';

class NoteRepositoryImpl extends NoteRepository {
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  FutureOr<Note?> addNote(
      {required String uid,
      required Note note,
      required NoteAddListeners noteAddListeners}) async {
    try {
      await firestoreInstance
          .collection("note")
          .add(note.toJson())
          .then((value) {
        noteAddListeners.successCreated();
      });
    } catch (e) {
      print(e);
    }

    return note;
  }

  @override
  Future<void> deleteNote(
      {required String name, required HomeListeners homeListeners}) async {
    try {
      String? uid;
      await firestoreInstance
          .collection("note")
          .where("name", isEqualTo: name)
          .get()
          .then((value) {
        uid = value.docs[0].id;
      });

      await firestoreInstance
          .collection("note")
          .doc(uid)
          .delete()
          .then((value) {
        homeListeners.successDeleted();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  FutureOr<Note?> updateNote(
      {required String name,
      required Note note,
      required NoteUpdateListeners noteUpdateListeners}) async {
    try {
 String? uid;
      await firestoreInstance
          .collection("note")
          .where("name", isEqualTo: name)
          .get()
          .then((value) {
        uid = value.docs[0].id;
      });


      await firestoreInstance.collection("note").doc(uid).update({
        "category": note.category,
        "content": note.content,
        "name": note.name,
        "lastUpdating": DateTime.now().toString()
      }).then((value) => {print("updated")});
    } catch (Exception) {
      print(Exception);
    }

    return note;
  }

  @override
  FutureOr<Note?> getNote({required String name}) async {
    Note? note;
    try {
      await firestoreInstance
          .collection("note")
          .where("name", isEqualTo: name)
          .get()
          .then((value) => {note = Note.fromJson(value.docs[0].data()!)});
    } catch (Exception) {
      print(Exception);
    }

    return note;
  }
}
