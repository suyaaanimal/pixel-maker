import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditCreateScreen extends StatefulWidget {
  const EditCreateScreen({super.key});

  @override
  State<EditCreateScreen> createState() => _EditCreateScreenState();
}

class _EditCreateScreenState extends State<EditCreateScreen> {
  final tc = TextEditingController();

  @override
  void dispose() {
    tc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text('大きさ(1辺のpixel数):'),
                SizedBox(
                  width: 100,
                  child: TextField(controller: tc),
                )
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final size = int.tryParse(tc.text);
                if (size == null) return;
                context.go('/edit/new?size=$size');
              },
              child: const Text('create'),
            )
          ],
        ),
      ),
    );
  }
}
