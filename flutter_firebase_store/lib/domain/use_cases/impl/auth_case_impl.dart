import 'dart:async';

import 'package:flutter_firebase_store/data/repository/interface/auth_repository.dart';
import 'package:flutter_firebase_store/domain/model/user.dart';
import 'package:flutter_firebase_store/domain/model/model_response.dart';
import 'package:flutter_firebase_store/domain/use_cases/interfaces/auth_case.dart';

import '../../../presentation/bloc/listeners/auth_registration_listeners.dart';

class AuthCaseImpl extends AuthCase {
  final AuthRepository _authRepository;

  AuthCaseImpl(this._authRepository);

  @override
  FutureOr<ModelResponse>? registerUser({required User user, required AuthRegistrationListener authRegistrationListener}) => _authRepository.registerUser(user: user, authRegistrationListener: authRegistrationListener);
  
  
}