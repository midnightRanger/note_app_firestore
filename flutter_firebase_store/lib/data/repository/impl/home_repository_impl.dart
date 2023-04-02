import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_store/domain/model/model_response.dart';
import 'package:flutter_firebase_store/presentation/bloc/home_page/home_page_cubit.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/home_listeners.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import '../../../domain/model/note.dart';
import '../interface/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  CollectionReference users = FirebaseFirestore.instance.collection('notes');
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Future<List<Note>?> getNotes(
      {required String uid, required HomeListeners homeListener}) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? uid = prefs.getString('uid');
    List<Note> notes = [];
    try {
      firestoreInstance
          .collection("note")
          .where("authorId", isEqualTo: uid)
          .get()
          .then((value) {
        value.docs.forEach((result) {
          print(result.data());
        });

       

        value.docs.forEach((result) {
          notes.add(Note.fromJson(result.data()));
          print(result.data());
          

          homeListener.successRetrieved();
          homeListener.myNotes(notes);

          print(notes);
        });

        // List<Note>? allNotes = (querySnapshot.docs as List).map((e) {
        //   return Note.fromJson(e);
        // }).toList();
      });
    } catch (Exception) {
      return null;
    }
    return null;
  }
}
