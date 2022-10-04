import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_state.dart';
import 'package:pixel_maker/src/enums/edit_screen_enum.dart';
import 'package:pixel_maker/src/enums/preview_pattern.dart';
import 'package:state_notifier/state_notifier.dart';

class EditScreenController extends StateNotifier<EditScreenState> {
  EditScreenController() : super(const EditScreenState.init());

  int get pageIndex => state.page.index;

  final _picker = ImagePicker();

  void updatePage(EditScreenEnum page) {
    state = state.copyWith(page: page);
  }

  void updatePenColor(Color color) {
    state = state.copyWith(penColor: color);
  }

  void changePreviewPattern(PreviewPattern? previewPattern) {
    if (previewPattern == null) return;
    state = state.copyWith(previewPattern: previewPattern);
  }

  void setPreviewImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    state = state.copyWith(file: File(image.path));
  }

  void setPreviewBackgroundDotted() async {}
}
