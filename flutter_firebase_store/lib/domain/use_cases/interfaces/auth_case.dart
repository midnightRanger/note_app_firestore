import 'dart:async';

import '../../model/ModelResponse.dart';
import '../../../domain/model/user.dart';
import '../../../presentation/bloc/listeners/auth_registration_listeners.dart';

abstract class AuthCase {
  FutureOr<ModelResponse>? registerUser({required User user, required AuthRegistrationListener authRegistrationListener});
}
