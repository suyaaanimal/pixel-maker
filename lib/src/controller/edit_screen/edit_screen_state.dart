import 'package:flutter/material.dart';
import 'package:pixel_maker/src/enums/edit_screen_enum.dart';

@immutable
class EditScreenState {
  const EditScreenState({
    required this.page,
    required this.eraseredColor,
  });
  const EditScreenState.init()
      : this(
          page: EditScreenEnum.pen,
          eraseredColor: const Color(0x00FFFFFF),
        );
  final EditScreenEnum page;
  final Color eraseredColor;
  EditScreenState copyWith({
    EditScreenEnum? page,
    Color? eraseredColor,
  }) {
    return EditScreenState(
      page: page ?? this.page,
      eraseredColor: eraseredColor ?? this.eraseredColor,
    );
  }
}
