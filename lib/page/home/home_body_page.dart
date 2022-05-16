import 'package:eyepetizer_flutter_demo/model/common_item.dart';
import 'package:eyepetizer_flutter_demo/state/base_list_state.dart';
import 'package:eyepetizer_flutter_demo/viewmodel/home/home_page_viewmodel.dart';
import 'package:eyepetizer_flutter_demo/widget/home/banner_widget.dart';
import 'package:eyepetizer_flutter_demo/widget/list_item_widget.dart';
import 'package:flutter/material.dart';

const TEXT_HEADER_TYPE = 'textHeader';

class HomeBodyPage extends StatefulWidget {
  const HomeBodyPage({Key? key}) : super(key: key);

  @override
  State<HomeBodyPage> createState() => _HomeBodyPageState();
}

class _HomeBodyPageState
    extends BaseListState<Item, HomePageViewModel, HomeBodyPage> {
  @override
  Widget getContentChild(HomePageViewModel model) {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (index == 0) {
          return _banner(model);
        } else {
          if (model.itemList[index].type == TEXT_HEADER_TYPE) {
            return _titleItem(model.itemList[index]);
          }
          return ListItemWidget(
            item: model.itemList[index],
          );
        }
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Divider(
            height: model.itemList[index].type == TEXT_HEADER_TYPE ? 0 : 0.5,
            color: model.itemList[index].type == TEXT_HEADER_TYPE
                ? Colors.transparent
                : const Color(0xffe6e6e6),
          ),
        );
      },
      itemCount: model.itemList.length,
    );
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

  Widget _titleItem(Item item) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white24),
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Center(
        child: Text(
          item.data!.text!,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
