import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Edit'),
                onPressed: () {
                  context.push('/edit');
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    context.push('/settings');
                  },
                  child: const Text('Settings')),
            ],
          )),
        ),
      ),
    );
  }
}
