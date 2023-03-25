import 'dart:async';

import 'package:flutter_firebase_store/presentation/bloc/home_page/home_page_cubit.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/home_listeners.dart';

import '../../../domain/model/ModelResponse.dart';
import '../../../domain/model/note.dart';
import '../../../presentation/bloc/listeners/note_add_listeners.dart';
import '../../../presentation/bloc/listeners/note_update_listeners.dart';

abstract class NoteRepository {
  FutureOr<Note?> addNote({required String uid, required Note note, required NoteAddListeners noteAddListeners});
  Future<void> deleteNote({required String name, required HomeListeners homeListeners});
  FutureOr<Note?> updateNote({required String name, required Note note, required NoteUpdateListeners noteUpdateListeners});
  FutureOr<Note?> getNote({required String name});
}