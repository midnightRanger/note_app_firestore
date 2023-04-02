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
import '../listeners/note_update_listeners.dart';
import '../listeners/profile_edit_listeners.dart';
import '../listeners/profile_listeners.dart';

class NoteEditState {
  final bool successUpdated;  
  final bool initial;
  final bool failed; 
  final Note? note; 

 NoteEditState({
    this.successUpdated = false,
    this.initial = false,
    this.failed = false,
    this.note = null 
  });  
}

class NoteEditPageCubit extends Cubit<NoteEditState> implements NoteUpdateListeners {
  final _noteRepository = NoteRepositoryImpl();

  NoteEditPageCubit(NoteEditState initialState) : super(initialState);

  Future<void> updateNote(Note note, String name) async {

    emit (NoteEditState(note: await _noteRepository.updateNote(name: name, note: note, noteUpdateListeners: this), successUpdated: true));
  }

  Future<void> init(String name) async {
    emit(NoteEditState(
        note: await _noteRepository.getNote(name: name)));
  }
  
  @override
  failed() {
    emit (NoteEditState(failed: true));
  }
  
  @override
  successUpdated() {
    emit (NoteEditState(successUpdated: true));
  }

  @override  
  note(Note? note) {
    emit (NoteEditState(note: note)); 
  }

}