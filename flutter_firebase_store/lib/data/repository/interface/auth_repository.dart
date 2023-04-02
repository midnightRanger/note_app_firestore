import 'dart:async';

import '../../../domain/model/model_response.dart';
import '../../../domain/model/user.dart';
import '../../../presentation/bloc/listeners/auth_registration_listeners.dart';

abstract class AuthRepository {
  FutureOr<ModelResponse>? registerUser({required User user, required AuthRegistrationListener authRegistrationListener});
  FutureOr<ModelResponse>? authUser({required User user, required AuthRegistrationListener authRegistrationListener}); 
}
