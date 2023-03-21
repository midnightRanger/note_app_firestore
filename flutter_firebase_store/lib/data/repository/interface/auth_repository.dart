import '../../../domain/model/ModelResponse.dart';
import '../../../domain/model/user.dart';

abstract class AuthRepository {
  ModelResponse registerUser(User user);
}
