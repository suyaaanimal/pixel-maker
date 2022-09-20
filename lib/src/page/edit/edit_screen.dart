import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_controller.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_state.dart';
import 'package:pixel_maker/src/controller/image/image_controller.dart';
import 'package:pixel_maker/src/controller/image/image_state.dart';
import 'package:pixel_maker/src/controller/user/user_controller.dart';
import 'package:pixel_maker/src/enums/edit_screen_enum.dart';
import 'package:pixel_maker/src/page/edit/widet/color_picker_zone.dart';
import 'package:pixel_maker/src/page/edit/widet/editable_zone.dart';
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
        return WillPopScope(
          onWillPop: () async {
            final data = context.read<ImageState>();
            final userController = context.read<UserController>();
            return await showDialog(
                context: context,
                builder: ((context) {
                  return AlertDialog(
                    title: const Text('保存しますか？'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('保存しない')),
                      TextButton(
                        onPressed: () async {
                          final bool result;
                          result = data.docId == ''
                              ? await userController.uploadNewImage(
                                  data.size,
                                  data.pixels,
                                )
                              : await userController.updateImage(
                                  data.docId,
                                  data.size,
                                  data.pixels,
                                );
                          Navigator.of(context).pop(result);
                        },
                        child: const Text('保存する'),
                      ),
                    ],
                  );
                }));
          },
          child: Scaffold(
              appBar: AppBar(),
              body: Center(
                  child: SizedBox(
                      child: screenState.page == EditScreenEnum.colorPicker
                          ? const ColorPickerZone()
                          : const EditableZone())),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: screenState.page.index,
                onTap: (value) =>
                    screenController.updatePage(EditScreenEnum.values[value]),
                type: BottomNavigationBarType.fixed,
                items: EditScreenEnum.values
                    .map((e) => BottomNavigationBarItem(
                        icon: Icon(e.icon), label: e.name))
                    .toList(),
              )),
        );
      }),
    );
  }
}
