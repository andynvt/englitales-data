import 'dart:convert';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class HomeModel extends ChangeNotifier {
  String fileName = '';
  final Map<String, dynamic> categories = {};
  final Map<String, dynamic> items = {};

  final List<PlutoColumn> cols = [];
  final List<PlutoRow> rows = [];

  HomeModel() {
    _initCols();
  }

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
      categories.clear();
      categories.addAll(json['categories']);

      items.clear();
      final ls = json['items'] as List;
      final map = Map.fromIterable(ls, key: (e) => e['id'].toString(), value: (e) => e);
      items.addAll(map);
      notifyListeners();
    }
  }

  void _initCols() {
    cols.clear();
    cols.addAll([
      PlutoColumn(
        title: 'ID',
        field: 'id',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'category',
        field: 'number_field',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'date column',
        field: 'date_field',
        type: PlutoColumnType.date(),
      ),
      PlutoColumn(
        title: 'time column',
        field: 'time_field',
        type: PlutoColumnType.time(),
      ),
    ]);
  }
}

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
}
