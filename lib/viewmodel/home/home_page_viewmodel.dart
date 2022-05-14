import 'package:eyepetizer_flutter_demo/http/Url.dart';
import 'package:eyepetizer_flutter_demo/http/http_manager.dart';
import 'package:eyepetizer_flutter_demo/model/common_item.dart';
import 'package:eyepetizer_flutter_demo/model/issue_model.dart';
import 'package:eyepetizer_flutter_demo/utils/toast_util.dart';
import 'package:eyepetizer_flutter_demo/viewmodel/base_change_notifier.dart';
import 'package:eyepetizer_flutter_demo/widget/loading_state_widget.dart';

class HomePageViewModel extends BaseChangeNotifier {
  List<Item> bannerList = [];

  void refresh() {
    HttpManager.getData(
      Url.feedUrl,
      success: (json) {
        IssueEntity issueEntity = IssueEntity.fromJson(json);
        bannerList = issueEntity.itemList!;
        bannerList.removeWhere((element) => element.type == 'banner2');
        loadingState = LoadingState.done;
      },
      fail: (e) {
        ToastUtil.showError(e.toString());
      },
      complete: () {
        notifyListeners();
      },
    );
  }

  retry() {
    loadingState = LoadingState.loading;
    notifyListeners();
    refresh();
  }
}
