import 'package:eyepetizer_flutter_demo/config/string.dart';
import 'package:eyepetizer_flutter_demo/utils/toast_util.dart';
import 'package:eyepetizer_flutter_demo/viewmodel/tab_navigation_viewmodel.dart';
import 'package:eyepetizer_flutter_demo/widget/provider_widget.dart';
import 'package:flutter/material.dart';

class TabNavigation extends StatefulWidget {
  const TabNavigation({Key? key}) : super(key: key);

  @override
  State<TabNavigation> createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  DateTime lastTime = DateTime.now();

  // late Widget _currentBody = Container(
  //   color: Colors.pink,
  // );
  //
  // int _currentIndex = 0;

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Container(color: Colors.pink,),
              Container(color: Colors.red,),
              Container(color: Colors.orange,),
              Container(color: Colors.yellow,),
            ],
          ),
            bottomNavigationBar: ProviderWidget<TabNavigationViewModel>(
                model: TabNavigationViewModel(),
                builder: (context, model, child) {
                  return BottomNavigationBar(
                    items: _items(),
                    currentIndex: model.currentIndex,
                    onTap: (index){
                      if(model.currentIndex != index) {
                        pageController.jumpToPage(index);
                        model.changeBottomTabIndex(index);
                      }
                    },
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: const Color(0xff000000),
                    unselectedItemColor: const Color(0xff9a9a9a),
                  );
                })),
        onWillPop: _onWillPop);
  }

  List<BottomNavigationBarItem> _items() {
    return [
      _bottomItem(MyString.home, 'images/ic_home_normal.png',
          'images/ic_home_selected.png'),
      _bottomItem(MyString.discovery, 'images/ic_discovery_normal.png',
          'images/ic_discovery_selected.png'),
      _bottomItem(MyString.hot, 'images/ic_hot_normal.png',
          'images/ic_hot_selected.png'),
      _bottomItem(MyString.mine, 'images/ic_mine_normal.png',
          'images/ic_mine_selected.png'),
    ];
  }

  _bottomItem(String title, String normalIcon, String selectedIcon) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        normalIcon,
        width: 24,
        height: 24,
      ),
      activeIcon: Image.asset(
        selectedIcon,
        width: 24,
        height: 24,
      ),
      label: title,
    );
  }

  Future<bool> _onWillPop() async {
    if (DateTime.now().difference(lastTime) > const Duration(seconds: 2)) {
      ToastUtil.showTip(MyString.exit_tip);
      lastTime = DateTime.now();
      return false;
    } else {
      return true;
    }
  }

  // _onTap(int index) {
  //   switch(index) {
  //     case 0:
  //       _currentBody = Container(color: Colors.pink,);
  //       break;
  //     case 1:
  //       _currentBody = Container(color: Colors.red,);
  //       break;
  //     case 2:
  //       _currentBody = Container(color: Colors.orange,);
  //       break;
  //     case 3:
  //       _currentBody = Container(color: Colors.yellow,);
  //       break;
  //   }
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }
}
