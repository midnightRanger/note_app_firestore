import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_store/data/repository/impl/home_repository_impl.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/home_listeners.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repository/impl/profile_repository_impl.dart';
import '../../../data/repository/interface/auth_repository.dart';
import '../../../domain/model/model_response.dart';
import '../../../domain/model/note.dart';
import '../../../domain/model/user.dart';
import '../listeners/profile_edit_listeners.dart';
import '../listeners/profile_listeners.dart';

class ProfileEditState {
  final bool successRetrieved;
  final bool successUpdated;  
  final bool initial;
  final bool failed; 
  final User? user;

 ProfileEditState({
    this.successRetrieved = false,
    this.initial = false,
    this.failed = false, 
    this.user = null,
    this.successUpdated = false
  });  
}

class ProfileEditPageCubit extends Cubit<ProfileEditState> implements ProfileEditListeners {
  final _profileRepository = ProfileRepositoryImpl();

  ProfileEditPageCubit(ProfileEditState initialState) : super(initialState);

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid')!; 
    emit(ProfileEditState(user: await _profileRepository.getUserForUpdate(uid: uid, profileListeners: this))
    );
    
  }

  Future<void> updateUser(User user) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid')!; 
    emit(ProfileEditState(user: await _profileRepository.updateUser(uid: uid, profileEditListeners: this, user: user))
    );
  }
  
  @override
  failed() {
    emit(ProfileEditState(
      failed: true,
    ));
  }
  
  
  @override
  successRetrieved() {
    emit(ProfileEditState(successRetrieved: true)); 
  }
  
  @override
  user(User? user) {
    emit(ProfileEditState(user: user));
  }
  
  @override
  successUpdated(User? user) {
    emit(ProfileEditState(successUpdated: true, user: user));

  }


}