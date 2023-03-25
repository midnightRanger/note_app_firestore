import '../../../domain/model/user.dart';

abstract class ProfileListeners { 
  successRetrieved();  
  failed();
  user(User? user);
}