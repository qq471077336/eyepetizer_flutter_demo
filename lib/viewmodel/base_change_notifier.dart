import 'package:eyepetizer_flutter_demo/widget/loading_state_widget.dart';
import 'package:flutter/material.dart';

class BaseChangeNotifier extends ChangeNotifier {

  LoadingState loadingState = LoadingState.loading;

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
