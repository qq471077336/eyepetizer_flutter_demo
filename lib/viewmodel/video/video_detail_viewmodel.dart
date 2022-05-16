import 'package:eyepetizer_flutter_demo/http/http_manager.dart';
import 'package:eyepetizer_flutter_demo/http/url.dart';
import 'package:eyepetizer_flutter_demo/model/common_item.dart';
import 'package:eyepetizer_flutter_demo/utils/toast_util.dart';
import 'package:eyepetizer_flutter_demo/viewmodel/base_change_notifier.dart';
import 'package:eyepetizer_flutter_demo/widget/loading_state_widget.dart';

class VideoDetailViewModel extends BaseChangeNotifier {
  List<Item> itemList = [];
  late int _videoId;

  void loadVideoData(int id) {
    _videoId = id;
    HttpManager.requestData('${Url.videoRelatedUrl}$id').then((res) {
      Issue issue = Issue.fromJson(res);
      itemList = issue.itemList!;
      loadingState = LoadingState.done;
    }).catchError((e) {
      ToastUtil.showError(e.toString());
      loadingState = LoadingState.error;
    }).whenComplete(() => notifyListeners());
  }

  retry() {
    loadingState = LoadingState.loading;
    notifyListeners();
    loadVideoData(_videoId);
  }
}
