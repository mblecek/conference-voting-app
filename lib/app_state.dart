import 'package:flutter/foundation.dart';

class AppState with ChangeNotifier {
  final Map<String, String> _images = new Map();

  Map<String, String> get images => _images;

  void setImage(String name, String path) {
    _images[name] = path;
    notifyListeners();
  }
}
