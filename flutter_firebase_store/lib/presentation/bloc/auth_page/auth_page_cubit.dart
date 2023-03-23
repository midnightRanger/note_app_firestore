
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_store/data/repository/impl/auth_repository_impl.dart';
import 'package:flutter_firebase_store/data/repository/interface/auth_repository.dart';

import '../../../DI.dart';
import '../../../domain/model/ModelResponse.dart';
import '../../../domain/model/user.dart';
import '../../../domain/use_cases/interfaces/auth_case.dart';
import '../listeners/auth_registration_listeners.dart';
import 'auth_page_state.dart';

enum RegisterUserState {
  success,
  user_exists,
  weak_password,
  failed,
  initial
}

class AuthPageCubit extends Cubit<RegisterUserState> implements AuthRegistrationListener {
  final _authRepository = AuthRepositoryImpl();

  

  AuthPageCubit(RegisterUserState initialState) : super(initialState);

  Future<void> registerUser(User user) async {
    ModelResponse? response = await _authRepository.registerUser(user: user, authRegistrationListener: this);

  }

  @override
  void failed() {
    emit(RegisterUserState.initial);
    emit(RegisterUserState.failed);
  }

  @override
  void success() {
    emit(RegisterUserState.success);
  }

  @override
  void userExists() {
    emit(RegisterUserState.initial);
    emit(RegisterUserState.user_exists);
  }

  @override
  void weakPassword() {
    emit(RegisterUserState.initial);
    emit(RegisterUserState.weak_password);
  }
}