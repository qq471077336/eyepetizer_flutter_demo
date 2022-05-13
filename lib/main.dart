import 'dart:io';

import 'package:eyepetizer_flutter_demo/app_init.dart';
import 'package:eyepetizer_flutter_demo/tab_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());

  //Flutter沉浸式状态栏，Platform.isAndroid 判断是否是Android手机
  if (Platform.isAndroid) {
    // setSystemUIOverlayStyle:用来设置状态栏顶部和底部样式
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AppInit.init(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          var widget = snapshot.connectionState == ConnectionState.done
              ? const TabNavigation()
              : const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
          return GetMaterialAppWidget(child: widget);
        });
  }
}

class GetMaterialAppWidget extends StatefulWidget {
  final Widget child;

  const GetMaterialAppWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<GetMaterialAppWidget> createState() => _GetMaterialAppWidgetState();
}

class _GetMaterialAppWidgetState extends State<GetMaterialAppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EyePetizer',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => widget.child,
      },
    );
  }
}
