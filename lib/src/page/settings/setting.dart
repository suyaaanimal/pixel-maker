import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('uid:${userState.user?.uid}'),
          Text('username:${userState.userName}'),
          ElevatedButton(
              onPressed: () {
                context.push('/settings/init_user');
              },
              child: const Text('ユーザ設定')),
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
