import 'dart:async' show Future;
import 'dart:io' show File;

import 'package:flutter/services.dart' show MethodChannel;
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;
import 'package:meta/meta.dart' show required;

class FilePicker {
  static const MethodChannel _channel = const MethodChannel('file_picker');

  static Future<File> get _getPDF async {
    var path = await _channel.invokeMethod('pickPDF');
    return path == null ? null : new File(path);
  }

  static Future<File> _getImage(ImageSource type) async {
    return await ImagePicker.pickImage(source: type);
  }

  static Future<File> getFilePath({@required FileType type}) async {
    switch (type) {
      case FileType.PDF:
        return _getPDF;
      case FileType.IMAGE:
        return _getImage(ImageSource.gallery);
      case FileType.CAPTURE:
        return _getImage(ImageSource.camera);
    }
    return null;
  }
}

enum FileType {
  PDF,
  IMAGE,
  CAPTURE,
}
