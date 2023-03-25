import 'dart:async';

import '../../../domain/model/ModelResponse.dart';
import '../../../domain/model/note.dart';
import '../../../presentation/bloc/listeners/note_add_listeners.dart';

abstract class NoteRepository {
  FutureOr<Note?> addNote({required String uid, required Note note, required NoteAddListeners noteAddListeners});
}