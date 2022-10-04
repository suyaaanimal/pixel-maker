import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pixel_maker/src/enums/edit_screen_enum.dart';
import 'package:pixel_maker/src/enums/preview_pattern.dart';
import 'package:pixel_maker/src/model/preview_background_dotted.dart';

@immutable
class EditScreenState {
  const EditScreenState({
    required this.page,
    required this.eraseredColor,
    required this.penColor,
    required this.previewPattern,
    this.file,
    required this.previewBackgroundDotted,
  });
  const EditScreenState.init()
      : this(
          page: EditScreenEnum.pen,
          eraseredColor: const Color(0x00FFFFFF),
          penColor: Colors.red,
          previewPattern: PreviewPattern.none,
          previewBackgroundDotted: const PreviewBackgroundDotted.init(),
        );
  final EditScreenEnum page;
  final Color eraseredColor;
  final Color penColor;
  final PreviewPattern previewPattern;
  final File? file;
  final PreviewBackgroundDotted previewBackgroundDotted;
  EditScreenState copyWith({
    EditScreenEnum? page,
    Color? eraseredColor,
    Color? penColor,
    PreviewPattern? previewPattern,
    File? file,
    PreviewBackgroundDotted? previewBackgroundDotted,
  }) {
    return EditScreenState(
      page: page ?? this.page,
      eraseredColor: eraseredColor ?? this.eraseredColor,
      penColor: penColor ?? this.penColor,
      previewPattern: previewPattern ?? this.previewPattern,
      file: file ?? this.file,
      previewBackgroundDotted:
          previewBackgroundDotted ?? this.previewBackgroundDotted,
    );
  }
}
