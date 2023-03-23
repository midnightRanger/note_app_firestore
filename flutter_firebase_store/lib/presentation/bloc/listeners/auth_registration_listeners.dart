
abstract class AuthRegistrationListener {
  void userNotFound();
  void wrongPassword(); 
  void successRegister();
  void successLogin(); 
  void failed();
  void userExists();
  void weakPassword();
}