import 'package:flutter/material.dart';

enum EditScreenEnum {
  pen(icon: Icons.abc),
  fill(icon: Icons.radio_button_checked_outlined),
  eraser(icon: Icons.error),
  spoit(icon: Icons.sports_martial_arts),
  colorPicker(icon: Icons.color_lens),
  preview(icon: Icons.remove_red_eye),
  ;

  const EditScreenEnum({
    required this.icon,
  });
  final IconData icon;
}
