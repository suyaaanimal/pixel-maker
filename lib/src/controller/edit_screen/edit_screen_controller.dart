import 'package:flutter/material.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_state.dart';
import 'package:pixel_maker/src/enums/edit_screen_enum.dart';
import 'package:state_notifier/state_notifier.dart';

class EditScreenController extends StateNotifier<EditScreenState> {
  EditScreenController() : super(const EditScreenState.init());

  int get pageIndex => state.page.index;

  void updatePage(EditScreenEnum page) {
    state = state.copyWith(page: page);
  }

  void updatePenColor(Color color) {
    state = state.copyWith(penColor: color);
  }
}
