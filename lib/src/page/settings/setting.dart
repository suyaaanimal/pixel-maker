import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pixel_maker/src/controller/user/user_state.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserState>();
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text('${userState.user?.uid}'),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text('Log out'),
          )
        ],
      )),
    );
  }
}
