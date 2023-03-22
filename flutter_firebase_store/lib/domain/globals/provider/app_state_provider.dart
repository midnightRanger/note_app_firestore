import 'package:flutter/foundation.dart';

class AppStateProvider with ChangeNotifier {
// lets define a method to check and manipulate onboard status
  void hasOnboarded() async {
    // Notify listener provides converted value to all it listeneres
    notifyListeners();
  }
}