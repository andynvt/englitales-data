import 'dart:convert';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  final data = <String, dynamic>{};
  String fileName = '';
  void pick() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null) {
      PlatformFile f = result.files.single;
      fileName = '${f.name} - ${formatBytes(f.size, 2)}';
      String d = String.fromCharCodes(f.bytes);
      final json = jsonDecode(d) as Map;
      data.clear();
      data.addAll(json);
      notifyListeners();
    }
  }
}

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
}
