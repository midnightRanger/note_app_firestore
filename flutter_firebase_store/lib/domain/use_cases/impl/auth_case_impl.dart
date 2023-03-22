import 'dart:async';

import 'package:flutter_firebase_store/data/repository/interface/auth_repository.dart';
import 'package:flutter_firebase_store/domain/model/user.dart';
import 'package:flutter_firebase_store/domain/model/ModelResponse.dart';
import 'package:flutter_firebase_store/domain/use_cases/interfaces/auth_case.dart';

class AuthCaseImpl extends AuthCase {
  final AuthRepository _authRepository;

  AuthCaseImpl(this._authRepository);

  @override
  FutureOr<ModelResponse>? registerUser(User user) => _authRepository.registerUser(user);
  
  
}