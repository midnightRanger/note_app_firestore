import 'dart:async';

import 'package:flutter_firebase_store/presentation/bloc/listeners/profile_listeners.dart';

import '../../../domain/model/user.dart';

abstract class ProfileRepository {
    FutureOr<User?> getUser({required String uid, required ProfileListeners profileListeners}); 
}