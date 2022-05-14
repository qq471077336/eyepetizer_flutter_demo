import 'package:eyepetizer_flutter_demo/config/string.dart';
import 'package:eyepetizer_flutter_demo/page/home/home_body_page.dart';
import 'package:eyepetizer_flutter_demo/widget/app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

///AutomaticKeepAliveClientMixin作用：切换tab后保留tab状态，避免initstate重复调用
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: appBar(MyString.home, showBack: false),
      body: const HomeBodyPage(),
      // LoadingStateWidget(
      //   loadingState: LoadingState.done,
      //   child: Container(
      //     color: Colors.pink,
      //   ),
      // ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
