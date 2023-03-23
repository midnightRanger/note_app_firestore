
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_store/data/repository/impl/auth_repository_impl.dart';
import 'package:flutter_firebase_store/data/repository/interface/auth_repository.dart';

import '../../../DI.dart';
import '../../../domain/model/ModelResponse.dart';
import '../../../domain/model/user.dart';
import '../../../domain/use_cases/interfaces/auth_case.dart';
import 'auth_page_state.dart';

enum RegisterUserState {
  success,
  user_exists,
  weak_password,
  failed,
  initial
}

class AuthPageCubit extends Cubit<AuthPageState> {
  final _authCase;

  AuthPageCubit(this._authCase) : super(AuthPageState(response: new ModelResponse(error: null, data: null, message: "ok"))) {
    emit(AuthPageState(response: new ModelResponse(error: null, data: null, message: "ok")));
  }

  Future<void> registerUser(User user) async {
    ModelResponse? response = await _authCase.registerUser(user);
    emit(AuthPageState(response: response));
  }
}