import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_store/data/repository/impl/home_repository_impl.dart';
import 'package:flutter_firebase_store/presentation/bloc/listeners/home_listeners.dart';

import '../../../data/repository/interface/auth_repository.dart';
import '../../../domain/model/ModelResponse.dart';

enum HomeActionState {
  successDeleted, 
  successRetrieved, 
  initial, 
  failed
}

class HomePageCubit extends Cubit<HomeActionState> implements HomeListeners {
  final _homeRepository = HomeRepositoryImpl();

  

  HomePageCubit(HomeActionState initialState) : super(initialState);

  Future<ModelResponse?> retrievedNotes() async {
    return await _homeRepository.getNotes(homeListener: this);
  }
  
  @override
  failed() {
emit(HomeActionState.initial);
    emit(HomeActionState.failed);
  }
  
  @override
  successDeleted() {
    emit(HomeActionState.successDeleted);
  }
  
  @override
  successRetrieved() {
    emit(HomeActionState.successRetrieved);
  }


  
}