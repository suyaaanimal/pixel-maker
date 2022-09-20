import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('とりあえずログイン'),
          onPressed: () async {
            try {
              await FirebaseAuth.instance.signInAnonymously();
              debugPrint("Signed in with temporary account.");
            } on FirebaseAuthException catch (e) {
              switch (e.code) {
                case "operation-not-allowed":
                  debugPrint(
                      "Anonymous auth hasn't been enabled for this project.");
                  break;
                default:
                  debugPrint("Unknown error.");
                  debugPrint('$e');
              }
            }
          },
        ),
      ),
    );
  }
}
