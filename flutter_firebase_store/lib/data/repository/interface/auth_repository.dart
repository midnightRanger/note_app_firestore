import 'dart:async';

import '../../../domain/model/ModelResponse.dart';
import '../../../domain/model/user.dart';

abstract class AuthRepository {
  FutureOr<ModelResponse>? registerUser(User user);
}
