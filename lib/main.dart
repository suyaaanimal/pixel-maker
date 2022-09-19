import 'package:flutter/material.dart';
import 'package:pixel_maker/src/page/edit/edit_screen.dart';
import 'package:pixel_maker/src/route/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: route.routeInformationParser,
      routeInformationProvider: route.routeInformationProvider,
      routerDelegate: route.routerDelegate,
    );
  }
}
