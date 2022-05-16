import 'package:eyepetizer_flutter_demo/http/url.dart';
import 'package:eyepetizer_flutter_demo/model/common_item.dart';
import 'package:eyepetizer_flutter_demo/model/issue_model.dart';
import 'package:eyepetizer_flutter_demo/viewmodel/base_list_viewmodel.dart';

class HomePageViewModel extends BaseListViewModel<Item, IssueEntity> {
  List<Item> bannerList = [];

  @override
  void doExtraAfterRefresh() async {
    await loadMore();
  }

  @override
  IssueEntity getModel(Map<String, dynamic> json) =>IssueEntity.fromJson(json);

  @override
  String getUrl() {
    return Url.feedUrl;
  }

  @override
  void getData(List<Item>? list) {
    bannerList = list!;
    itemList?.clear();
    itemList?.add(Item());
  }

  @override
  void removeUselessData(List<Item>? list) {
      list?.removeWhere((element) => element.type == 'banner2');
  }
}
