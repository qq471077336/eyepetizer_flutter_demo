import 'package:eyepetizer_flutter_demo/model/common_item.dart';
import 'package:eyepetizer_flutter_demo/state/base_list_state.dart';
import 'package:eyepetizer_flutter_demo/viewmodel/home/home_page_viewmodel.dart';
import 'package:eyepetizer_flutter_demo/widget/home/banner_widget.dart';
import 'package:flutter/material.dart';

class HomeBodyPage extends StatefulWidget {
  const HomeBodyPage({Key? key}) : super(key: key);

  @override
  State<HomeBodyPage> createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends BaseListState<Item, HomePageViewModel, HomeBodyPage> {

  @override
  Widget getContentChild(HomePageViewModel model) {
    return _banner(model);
  }

  @override
  HomePageViewModel get viewModel => HomePageViewModel();

  _banner(model) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: BannerWidget(model: model),
      ),
    );
  }

}
