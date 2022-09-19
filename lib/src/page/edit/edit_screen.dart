import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_controller.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_state.dart';
import 'package:pixel_maker/src/controller/image/image_controller.dart';
import 'package:pixel_maker/src/controller/image/image_state.dart';
import 'package:pixel_maker/src/enums/edit_screen_enum.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<ImageController, ImageState>(
            create: (context) => ImageController()),
        StateNotifierProvider<EditScreenController, EditScreenState>(
            create: (context) => EditScreenController())
      ],
      child: Builder(builder: (context) {
        final screenState = context.watch<EditScreenState>();
        final screenController = context.read<EditScreenController>();
        return Scaffold(
            body: const Center(child: Text('Edit Screen')),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: screenState.page.index,
              onTap: (value) =>
                  screenController.changePage(EditScreenEnum.values[value]),
              type: BottomNavigationBarType.fixed,
              items: EditScreenEnum.values
                  .map((e) => BottomNavigationBarItem(
                      icon: Icon(e.icon), label: e.name))
                  .toList(),
            ));
      }),
    );
  }
}
