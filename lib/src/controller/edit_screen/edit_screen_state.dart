import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pixel_maker/src/constant/edit_screen.dart';
import 'package:pixel_maker/src/enums/edit_screen_enum.dart';
import 'package:pixel_maker/src/enums/preview_pattern.dart';
import 'package:pixel_maker/src/model/preview_background_dotted.dart';

@immutable
class EditScreenState {
  const EditScreenState({
    required this.page,
    required this.eraseredColor,
    required this.pen,
    required this.previewPattern,
    this.file,
    required this.previewBackgroundDotted,
    required this.pallet,
  });
  EditScreenState.init()
      : this(
            page: EditScreenEnum.pen,
            eraseredColor: const Color(0x00FFFFFF),
            pen: 0,
            previewPattern: PreviewPattern.none,
            previewBackgroundDotted: const PreviewBackgroundDotted.init(),
            pallet: [
              Colors.red,
              for (int i = 0; i < palletNum - 1; i++) Colors.white
            ]);
  final EditScreenEnum page;
  final Color eraseredColor;
  final int pen;
  final PreviewPattern previewPattern;
  final File? file;
  final PreviewBackgroundDotted previewBackgroundDotted;
  final List<Color> pallet;
  EditScreenState copyWith({
    EditScreenEnum? page,
    Color? eraseredColor,
    int? pen,
    PreviewPattern? previewPattern,
    File? file,
    PreviewBackgroundDotted? previewBackgroundDotted,
    List<Color>? pallet,
  }) {
    return EditScreenState(
      page: page ?? this.page,
      eraseredColor: eraseredColor ?? this.eraseredColor,
      pen: pen ?? this.pen,
      previewPattern: previewPattern ?? this.previewPattern,
      file: file ?? this.file,
      previewBackgroundDotted:
          previewBackgroundDotted ?? this.previewBackgroundDotted,
      pallet: pallet ?? this.pallet,
    );
  }
}
