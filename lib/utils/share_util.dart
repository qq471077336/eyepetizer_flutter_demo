import 'package:eyepetizer_flutter_demo/utils/toast_util.dart';
import 'package:share_plus/share_plus.dart';

void share(String title, String content) {
  Share.share('$title\n$content');
}
