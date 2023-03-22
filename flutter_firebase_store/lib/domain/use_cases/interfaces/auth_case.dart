import 'dart:async';

import '../../../domain/model/ModelResponse.dart';
import '../../../domain/model/user.dart';

abstract class AuthCase {
  FutureOr<ModelResponse>? registerUser(User user);
}
