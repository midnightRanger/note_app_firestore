import '../../../domain/model/user.dart';

abstract class ProfileEditListeners { 
  successRetrieved();  
  failed();
  user(User? user);
  successUpdated(User? user); 
}