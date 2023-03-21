import '../../../domain/model/ModelResponse.dart';
import '../../../domain/model/user.dart';

abstract class AuthCase {
  ModelResponse? registerUser(User user);
}
