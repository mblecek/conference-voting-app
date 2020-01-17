import 'package:flutter/foundation.dart';

class AppState with ChangeNotifier {
  final Map<int, String> _images = new Map();

  Map<int, String> get images => _images;

  void setImage(int index, String path) {
    _images[index] = path;
    notifyListeners();
  }
}
