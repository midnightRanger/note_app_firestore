import 'dart:async';

import 'package:flutter_firebase_store/presentation/bloc/listeners/profile_listeners.dart';

import '../../../domain/model/user.dart';
import '../../../presentation/bloc/listeners/profile_edit_listeners.dart';

abstract class ProfileRepository {
    FutureOr<User?> getUser({required String uid, required ProfileListeners profileListeners}); 
    FutureOr<User?> getUserForUpdate({required String uid, required ProfileEditListeners profileListeners}); 
    FutureOr<void> updateUser({required String uid, required ProfileEditListeners profileEditListeners, required User? user});
}