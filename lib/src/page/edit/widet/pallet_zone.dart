import 'package:flutter/material.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_controller.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_state.dart';
import 'package:provider/provider.dart';

class PalletZone extends StatelessWidget {
  const PalletZone({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditScreenState>();
    final controller = context.read<EditScreenController>();
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < state.pallet.length; i++)
            GestureDetector(
              onTap: () => controller.updatePen(i),
              child: Container(
                width: 32,
                height: 32,
                decoration: i != state.pen
                    ? BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                          strokeAlign: StrokeAlign.center,
                        ),
                        color: state.pallet[i],
                        shape: BoxShape.circle,
                      )
                    : BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 3,
                          strokeAlign: StrokeAlign.center,
                        ),
                        color: state.pallet[i],
                        shape: BoxShape.circle,
                      ),
              ),
            )
        ],
      ),
    );
  }
}
