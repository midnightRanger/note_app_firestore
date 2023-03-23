import 'dart:async';

import 'package:flutter_firebase_store/domain/model/ModelResponse.dart';

import '../../../presentation/bloc/listeners/home_listeners.dart';

abstract class HomeRepository {
  FutureOr<ModelResponse>? getNotes({required HomeListeners homeListener}); 
}