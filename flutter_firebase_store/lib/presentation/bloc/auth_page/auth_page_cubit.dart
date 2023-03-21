
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_page_state.dart';

class AuthPageCubit extends Cubit<AuthPageState> {
  AuthPageCubit() : super(AuthPageState(count: 0));

  void incrementCounter() {
    emit(AuthPageState(count: state.count+1));
  }
}