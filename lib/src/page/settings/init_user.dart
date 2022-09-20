import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_maker/src/controller/user/user_controller.dart';
import 'package:provider/provider.dart';

class InitUserScreen extends StatefulWidget {
  const InitUserScreen({super.key});

  @override
  State<InitUserScreen> createState() => _InitUserScreenState();
}

class _InitUserScreenState extends State<InitUserScreen> {
  final tc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('ユーザー名:'),
          TextField(controller: tc),
          ElevatedButton(
              onPressed: () async {
                try {
                  await context.read<UserController>().updataName(tc.text);
                  if (!mounted) return;
                  context.pop();
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              child: const Text('start'))
        ]),
      ),
    );
  }
}
