import 'dart:async';

import 'package:flutter_firebase_store/domain/model/ModelResponse.dart';

abstract class HomeRepository {
  FutureOr<ModelResponse>? getNotes(); 
}