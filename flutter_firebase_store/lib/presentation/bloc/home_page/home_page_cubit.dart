import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_store/data/repository/impl/home_repository_impl.dart';
import 'package:flutter_firebase_store/data/repository/impl/note_repository_impl.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/home_listeners.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repository/interface/auth_repository.dart';
import '../../../domain/model/ModelResponse.dart';
import '../../../domain/model/note.dart';

class HomeActionState {
  final bool successDeleted;
  final bool successRetrieved;
  final bool initial;
  final bool failed;
  final bool refresh;
  final List<Note>? myNotes;

  const HomeActionState(
      {this.successDeleted = false,
      this.successRetrieved = false,
      this.myNotes = const [],
      this.initial = false,
      this.failed = false,
      this.refresh = false});
}

class HomePageCubit extends Cubit<HomeActionState> implements HomeListeners {
  final _homeRepository = HomeRepositoryImpl();
  final _noteRepository = NoteRepositoryImpl();

  HomePageCubit(HomeActionState initialState) : super(initialState);

  Future<List<Note>?> retrievedNotes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid')!;
    return await _homeRepository.getNotes(homeListener: this, uid: uid);
  }

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid')!;
    emit(HomeActionState(
        myNotes: await _homeRepository.getNotes(uid: uid, homeListener: this)));
  }

  Future<void> deleteNote(String name) async {
    await _noteRepository.deleteNote(homeListeners: this, name: name);
  }

  @override
  failed() {
    emit(HomeActionState(
      failed: true,
    ));
  }

  @override
  successDeleted() {
    emit(HomeActionState(
      successDeleted: true,
    ));
  }

  @override
  successRetrieved() {
    emit(HomeActionState(successRetrieved: true));
  }

  @override
  myNotes(List<Note> notes) {
    emit(HomeActionState(myNotes: notes));
  }

  @override
  refresh() {
    emit(HomeActionState(refresh: true));
  }
}
