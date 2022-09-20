import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_controller.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_state.dart';
import 'package:pixel_maker/src/controller/image/image_controller.dart';
import 'package:pixel_maker/src/controller/image/image_state.dart';
import 'package:pixel_maker/src/page/edit/edit_screen.dart';
import 'package:provider/provider.dart';

class EditNewProvider extends StatelessWidget {
  const EditNewProvider({super.key, required this.size});
  final int size;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<ImageController, ImageState>(
            create: (context) => ImageController(size: size)),
        StateNotifierProvider<EditScreenController, EditScreenState>(
            create: (context) => EditScreenController())
      ],
      child: const EditScreen(),
    );
  }
}
