import 'dart:async';

import 'package:flutter_firebase_store/domain/model/ModelResponse.dart';

import '../../../domain/model/note.dart';
import '../../../presentation/bloc/listeners/home_listeners.dart';

abstract class HomeRepository {
  FutureOr<List<Note>?> getNotes({required String uid, required HomeListeners homeListener}); 
}