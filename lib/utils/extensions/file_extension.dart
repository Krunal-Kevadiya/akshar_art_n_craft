import 'package:image_picker/image_picker.dart';

extension FileExtension on XFile {
  String get getName {
    return path.split('/').last;
  }

  String get getExtension {
    return path.split('.').last;
  }
}
