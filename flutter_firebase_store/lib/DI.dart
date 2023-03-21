import 'package:flutter_firebase_store/data/repository/impl/auth_repository_impl.dart';
import 'package:flutter_firebase_store/data/repository/interface/auth_repository.dart';
import 'package:flutter_firebase_store/domain/use_cases/impl/auth_case_impl.dart';
import 'package:flutter_firebase_store/domain/use_cases/interfaces/auth_case.dart';

class DI {
  static DI? instance;

  late AuthRepository authRepository;
  late AuthCase authCase;

  DI._();

  static DI getInstance() {
    return instance ?? (instance = DI._());
  }

  Future<void> init() async {
    authRepository = AuthRepositoryImpl();
    authCase = AuthCaseImpl(authRepository);
  }
}