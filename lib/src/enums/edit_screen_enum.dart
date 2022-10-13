import 'package:flutter/material.dart';

enum EditScreenEnum {
  pen(icon: Icons.edit),
  fill(icon: Icons.format_color_fill),
  eraser(icon: Icons.format_color_reset),
  spoit(icon: Icons.colorize),
  colorPicker(icon: Icons.palette),
  preview(icon: Icons.remove_red_eye),
  ;

  const EditScreenEnum({
    required this.icon,
  });
  final IconData icon;
}
