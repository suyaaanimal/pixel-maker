import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_controller.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_state.dart';
import 'package:pixel_maker/src/controller/image/image_state.dart';
import 'package:pixel_maker/src/controller/user/user_controller.dart';
import 'package:pixel_maker/src/enums/edit_screen_enum.dart';
import 'package:pixel_maker/src/page/edit/widet/color_picker_zone.dart';
import 'package:pixel_maker/src/page/edit/widet/editable_zone.dart';
import 'package:pixel_maker/src/page/edit/widet/pallet_zone.dart';
import 'package:pixel_maker/src/page/edit/widet/preview_zone.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(context) {
    final screenState = context.watch<EditScreenState>();
    final screenController = context.read<EditScreenController>();
    return WillPopScope(
      onWillPop: () async {
        final data = context.read<ImageState>();
        final userController = context.read<UserController>();
        final result = await showDialog(
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
        if (result == true) {
          context.go('/');
        }
        return false;
      },
      child: Scaffold(
          appBar: AppBar(),
          body: Center(child: SizedBox(child: () {
            switch (screenState.page) {
              case EditScreenEnum.pen:
              case EditScreenEnum.fill:
              case EditScreenEnum.spoit:
                return Column(
                  children: const [
                    EditableZone(),
                    SizedBox(height: 10),
                    PalletZone(),
                  ],
                );
              case EditScreenEnum.eraser:
                return const EditableZone();
              case EditScreenEnum.colorPicker:
                return Column(
                  children: const [
                    ColorPickerZone(),
                    PalletZone(),
                  ],
                );
              case EditScreenEnum.preview:
                return const PreviewZone();
            }
          }())),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: screenState.page.index,
            onTap: (value) =>
                screenController.updatePage(EditScreenEnum.values[value]),
            type: BottomNavigationBarType.fixed,
            items: EditScreenEnum.values
                .map((e) => BottomNavigationBarItem(
                    icon: e != EditScreenEnum.colorPicker
                        ? Icon(e.icon)
                        : Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                color: screenState.pallet[screenState.pen],
                                borderRadius: BorderRadius.circular(4)),
                          ),
                    label: e.name))
                .toList(),
          )),
    );
  }
}
