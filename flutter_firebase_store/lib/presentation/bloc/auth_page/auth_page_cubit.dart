
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_store/data/repository/impl/auth_repository_impl.dart';
import 'package:flutter_firebase_store/data/repository/interface/auth_repository.dart';

import '../../../DI.dart';
import '../../../domain/model/ModelResponse.dart';
import '../../../domain/model/user.dart';
import '../../../domain/use_cases/interfaces/auth_case.dart';
import '../listeners/auth_registration_listeners.dart';
import 'auth_page_state.dart';

enum AuthUserState {
  successRegister,
  successLogin,
  userNotFound,
  wrongPassword,
  user_exists,
  weak_password,
  failed,
  initial
}

class AuthPageCubit extends Cubit<AuthUserState> implements AuthRegistrationListener {
  final _authRepository = AuthRepositoryImpl();

  AuthPageCubit(AuthUserState initialState) : super(initialState);

  Future<void> registerUser(User user) async {
    ModelResponse? response = await _authRepository.registerUser(user: user, authRegistrationListener: this);
  }

  Future<void> loginUser(User user) async {
    ModelResponse? response = await _authRepository.authUser(user: user, authRegistrationListener: this); 
  }


  @override
  void failed() {
    emit(AuthUserState.initial);
    emit(AuthUserState.failed);
  }

  @override
  void successRegister() {
    emit(AuthUserState.successRegister);
  }

  @override
  void successLogin() {
    emit(AuthUserState.successLogin);
  }

  @override
  void userExists() {
    emit(AuthUserState.initial);
    emit(AuthUserState.user_exists);
  }

  @override
  void weakPassword() {
    emit(AuthUserState.initial);
    emit(AuthUserState.weak_password);
  }
  
  @override
  void userNotFound() {
    emit(AuthUserState.initial);
    emit(AuthUserState.userNotFound);
  }
  
  @override
  void wrongPassword() {
    emit(AuthUserState.initial);
    emit(AuthUserState.wrongPassword);
  }
}