import 'package:flutter/material.dart';

class BaseChangeNotifier extends ChangeNotifier {

  bool _dispose = false;

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }

  @override
  void notifyListeners() {
    if(!_dispose) {
      super.notifyListeners();
    }
  }
}
