import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_store/data/repository/impl/home_repository_impl.dart';
import 'package:flutter_firebase_store/data/repository/impl/note_repository_impl.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/home_listeners.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/note_add_listeners.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repository/impl/profile_repository_impl.dart';
import '../../../data/repository/interface/auth_repository.dart';
import '../../../domain/model/model_response.dart';
import '../../../domain/model/note.dart';
import '../../../domain/model/user.dart';
import '../listeners/profile_edit_listeners.dart';
import '../listeners/profile_listeners.dart';

class NoteAddState {
  final bool successCreated;  
  final bool initial;
  final bool failed; 

 NoteAddState({
    this.successCreated = false,
    this.initial = false,
    this.failed = false, 
  });  
}

class NoteAddPageCubit extends Cubit<NoteAddState> implements NoteAddListeners {
  final _noteRepository = NoteRepositoryImpl();

  NoteAddPageCubit(NoteAddState initialState) : super(initialState);

  Future<void> addNote(Note note, dynamic file) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid')!; 
    var updatedNote = Note(status: note.status, authorId: uid, category: note.category, content: note.content, name: note.name, 
    lastUpdating: note.lastUpdating, creationDate: note.creationDate, image: note.image);
    await _noteRepository.addNote(uid: uid, note: updatedNote, noteAddListeners: this, file: file);
  }
  
  @override
  failed() {
    emit (NoteAddState(failed: true));
  }
  
  @override
  successCreated() {
    emit (NoteAddState(successCreated: true));
  }

}