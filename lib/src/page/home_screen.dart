import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            ElevatedButton(
              child: const Text('Edit'),
              onPressed: () {
                context.go('/edit');
              },
            ),
            ElevatedButton(
                onPressed: () {
                  context.go('/settings');
                },
                child: const Text('Settings')),
          ],
        )),
      ),
    );
  }
}
