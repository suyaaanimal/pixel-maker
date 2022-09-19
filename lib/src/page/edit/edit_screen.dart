import 'dart:math';

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
            body: Center(
                child: SizedBox(
                    height: 250,
                    width: 250,
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        final pixelBorderWidth =
                            screenState.page == EditScreenEnum.preview
                                ? 0.0
                                : 1.0;
                        final pixelOneSideSize =
                            context.watch<ImageState>().size;
                        final wholeOneSideLength =
                            min(constraint.maxHeight, constraint.maxWidth) -
                                pixelBorderWidth * 2;
                        final pixelOneSideLength =
                            wholeOneSideLength / pixelOneSideSize;
                        return Center(
                          child: InteractiveViewer(
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      screenState.page == EditScreenEnum.preview
                                          ? null
                                          : Border.all(
                                              color: Colors.grey,
                                              width: pixelBorderWidth)),
                              child: Column(
                                  children: context
                                      .read<ImageState>()
                                      .pixels
                                      .map(
                                        (rowPixels) => Row(
                                          children: rowPixels
                                              .map((e) => GestureDetector(
                                                    child: Container(
                                                      padding: EdgeInsets.zero,
                                                      width: pixelOneSideLength,
                                                      height:
                                                          pixelOneSideLength,
                                                      decoration: BoxDecoration(
                                                          border: screenState
                                                                      .page ==
                                                                  EditScreenEnum
                                                                      .preview
                                                              ? null
                                                              : Border.all(
                                                                  width:
                                                                      pixelBorderWidth,
                                                                  color: Colors
                                                                      .grey,
                                                                  strokeAlign:
                                                                      StrokeAlign
                                                                          .outside,
                                                                ),
                                                          color: e),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      )
                                      .toList()),
                            ),
                          ),
                        );
                      },
                    ))),
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
