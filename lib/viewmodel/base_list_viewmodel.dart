import 'package:eyepetizer_flutter_demo/http/http_manager.dart';
import 'package:eyepetizer_flutter_demo/model/paging_model.dart';
import 'package:eyepetizer_flutter_demo/utils/toast_util.dart';
import 'package:eyepetizer_flutter_demo/viewmodel/base_change_notifier.dart';
import 'package:eyepetizer_flutter_demo/widget/loading_state_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseListViewModel<T, M extends PagingModel<T>>
    extends BaseChangeNotifier {
  List<T> itemList = [];

  late String? nextPageUrl;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void refresh() {
    HttpManager.getData(
      getUrl(),
      success: (json) {
        M model = getModel(json);
        removeUselessData(model.itemList);
        getData(model.itemList);
        // bannerList = issueEntity.itemList!;
        // bannerList.removeWhere((element) => element.type == 'banner2');
        loadingState = LoadingState.done;

        //下一页
        nextPageUrl = getNextPageUrl(model);
        refreshController.refreshCompleted();
        refreshController.footerMode?.value = LoadStatus.canLoading;

        doExtraAfterRefresh();
      },
      fail: (e) {
        ToastUtil.showError(e.toString());
        refreshController.refreshFailed();
        loadingState = LoadingState.error;
      },
      complete: () {
        notifyListeners();
      },
    );
  }

  ///加载更多
  Future<void> loadMore() async {
    if (nextPageUrl == null) {
      refreshController.loadNoData();
      return;
    }

    HttpManager.getData(nextPageUrl!, success: (json) {
      M model = getModel(json);
      removeUselessData(model.itemList);
      itemList.addAll(model.itemList!);
      nextPageUrl = getNextPageUrl(model);
      refreshController.loadComplete();
      notifyListeners();
    }, fail: (e) {
      ToastUtil.showError(e.toString());
      refreshController.refreshFailed();
    });
  }

  retry() {
    loadingState = LoadingState.loading;
    notifyListeners();
    refresh();
  }

  ///请求地址
  String getUrl();

  ///请求返回的真实数据类型
  M getModel(Map<String, dynamic> json);

  void removeUselessData(List<T>? itemList) {}

  void getData(List<T>? itemList) {
    this.itemList = itemList!;
  }

  String? getNextPageUrl(M model) {
    return model.nextPageUrl;
  }

  ///额外操作
  void doExtraAfterRefresh();
}
