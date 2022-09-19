import 'package:flutter/material.dart';
import 'package:pixel_maker/src/enums/edit_screen_enum.dart';

@immutable
class EditScreenState {
  const EditScreenState({
    required this.page,
    required this.eraseredColor,
    required this.penColor,
  });
  const EditScreenState.init()
      : this(
          page: EditScreenEnum.pen,
          eraseredColor: const Color(0x00FFFFFF),
          penColor: Colors.red,
        );
  final EditScreenEnum page;
  final Color eraseredColor;
  final Color penColor;
  EditScreenState copyWith({
    EditScreenEnum? page,
    Color? eraseredColor,
    Color? penColor,
  }) {
    return EditScreenState(
      page: page ?? this.page,
      eraseredColor: eraseredColor ?? this.eraseredColor,
      penColor: penColor ?? this.penColor,
    );
  }
}
