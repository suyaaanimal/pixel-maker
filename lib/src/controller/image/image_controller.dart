import 'package:pixel_maker/src/controller/image/image_state.dart';
import 'package:state_notifier/state_notifier.dart';

class ImageController extends StateNotifier<ImageState> {
  ImageController({size = 16}) : super(ImageState(size));
}
