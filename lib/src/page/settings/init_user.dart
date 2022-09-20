import 'package:flutter/material.dart';

class InitUserScreen extends StatelessWidget {
  const InitUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          TextField(),
          ElevatedButton(onPressed: () {}, child: Text('start'))
        ]),
      ),
    );
  }
}
