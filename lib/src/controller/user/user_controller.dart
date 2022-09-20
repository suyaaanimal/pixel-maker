import 'package:firebase_auth/firebase_auth.dart';
import 'package:pixel_maker/src/controller/user/user_state.dart';
import 'package:state_notifier/state_notifier.dart';

class UserController extends StateNotifier<UserState> {
  UserController() : super(const UserState()) {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      state = state.copyWidth(user: event);
    });
  }

  Future<void> updataName(String name) async {}
}
