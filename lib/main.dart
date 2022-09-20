import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pixel_maker/firebase_options.dart';
import 'package:pixel_maker/src/route/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
