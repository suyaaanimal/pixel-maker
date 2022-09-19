import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_controller.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_state.dart';
import 'package:provider/provider.dart';

class ColorPickerZone extends StatelessWidget {
  const ColorPickerZone({super.key});

  @override
  Widget build(BuildContext context) {
    final screenController = context.read<EditScreenController>();
    final screenState = context.watch<EditScreenState>();
    return ColorPicker(
        pickerColor: screenState.penColor,
        onColorChanged: ((value) => screenController.updatePenColor(value)));
  }
}
