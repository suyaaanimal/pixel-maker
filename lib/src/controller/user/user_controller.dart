import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pixel_maker/src/controller/user/user_state.dart';
import 'package:state_notifier/state_notifier.dart';

class UserController extends StateNotifier<UserState> {
  final _db = FirebaseFirestore.instance;
  UserController() : super(const UserState()) {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      state = state.copyWidth(user: event, userName: event?.uid);
      initUserInfo();
    });
  }

  Future<void> updataName(String name) async {
    await _db.collection('user').doc(state.user?.uid).set({
      'userName': name,
    });
    state = state.copyWidth(userName: name);
  }

  Future<void> initUserInfo() async {
    final data = await _db.collection('user').doc(state.user?.uid).get();
    if (!data.exists) throw Exception('No user data');
    state = state.copyWidth(userName: data.data()?['userName']);
  }
}
