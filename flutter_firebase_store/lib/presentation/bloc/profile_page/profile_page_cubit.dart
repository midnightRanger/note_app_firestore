import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_store/data/repository/impl/home_repository_impl.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/home_listeners.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repository/impl/profile_repository_impl.dart';
import '../../../data/repository/interface/auth_repository.dart';
import '../../../domain/model/ModelResponse.dart';
import '../../../domain/model/note.dart';
import '../../../domain/model/user.dart';
import '../listeners/profile_listeners.dart';

class ProfileState {
  final bool successRetrieved; 
  final bool initial;
  final bool failed; 
  final User? user;

 ProfileState({
    this.successRetrieved = false,
    this.initial = false,
    this.failed = false, 
    this.user = null
  });  
}

class ProfilePageCubit extends Cubit<ProfileState> implements ProfileListeners {
  final _profileRepository = ProfileRepositoryImpl();

  ProfilePageCubit(ProfileState initialState) : super(initialState);

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid')!; 
    emit(ProfileState(user: await _profileRepository.getUser(uid: uid, profileListeners: this))
    );
    
  }
  
  @override
  failed() {
    emit(ProfileState(
      failed: true,
    ));
  }
  
  
  @override
  successRetrieved() {
    emit(ProfileState(successRetrieved: true)); 
  }
  
  @override
  user(User? user) {
    emit(ProfileState(user: user));
  }


}