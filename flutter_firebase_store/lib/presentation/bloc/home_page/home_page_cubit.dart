import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/interface/auth_repository.dart';

enum HomeActionState {
  successRegister,
  successLogin,
  userNotFound,
  wrongPassword,
  user_exists,
  weak_password,
  failed,
  initial
}

class AuthPageCubit extends Cubit<HomeActionState> implements AuthRegistrationListener {
  final _authRepository = AuthRepository();

  

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