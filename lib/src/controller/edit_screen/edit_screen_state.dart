import 'package:flutter/material.dart';
import 'package:pixel_maker/src/enums/edit_screen_enum.dart';

@immutable
class EditScreenState {
  const EditScreenState({
    required this.page,
  });
  const EditScreenState.init() : this(page: EditScreenEnum.pen);
  final EditScreenEnum page;
  EditScreenState copyWith({EditScreenEnum? page}) {
    return EditScreenState(
      page: page ?? this.page,
    );
  }
}
