import 'package:eyepetizer_flutter_demo/config/color.dart';
import 'package:eyepetizer_flutter_demo/config/string.dart';
import 'package:flutter/material.dart';

enum LoadingState { loading, done, error }

class LoadingStateWidget extends StatelessWidget {
  final VoidCallback? retry;
  final LoadingState loadingState;
  final Widget child;

  const LoadingStateWidget(
      {Key? key,
      this.loadingState = LoadingState.loading,
      this.retry,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loadingState == LoadingState.loading) {
      return _loadingView;
    } else if (loadingState == LoadingState.error) {
      return _errorView;
    } else {
      return child;
    }
  }

  Widget get _loadingView {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget get _errorView {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/ic_error.png',
            width: 64,
            height: 64,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              MyString.net_request_fail,
              style: TextStyle(color: MyColor.hitTextColor, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: OutlinedButton(
              onPressed: retry,
              child: const Text(
                MyString.reload_again,
                style: TextStyle(color: Colors.black87),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.black12)),
            ),
          ),
        ],
      ),
    );
  }
}
