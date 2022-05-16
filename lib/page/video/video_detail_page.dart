import 'package:eyepetizer_flutter_demo/config/string.dart';
import 'package:eyepetizer_flutter_demo/utils/cache_image.dart';
import 'package:eyepetizer_flutter_demo/utils/date_util.dart';
import 'package:eyepetizer_flutter_demo/utils/navigator_util.dart';
import 'package:eyepetizer_flutter_demo/viewmodel/video/video_detail_viewmodel.dart';
import 'package:eyepetizer_flutter_demo/widget/video/video_play_widget.dart';
import 'package:eyepetizer_flutter_demo/widget/video/video_item_widget.dart';
import 'package:eyepetizer_flutter_demo/widget/loading_state_widget.dart';
import 'package:eyepetizer_flutter_demo/widget/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/common_item.dart';

const VIDEO_SMALL_CARD_TYPE = 'videoSmallCard';

class VideoDetailPage extends StatefulWidget {
  final Data? videoDta;

  const VideoDetailPage({Key? key, this.videoDta}) : super(key: key);

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with WidgetsBindingObserver {
  final GlobalKey<VideoPlayWidgetState> videoKey = GlobalKey();

  late Data data;

  @override
  void initState() {
    super.initState();
    data = widget.videoDta ?? arguments();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      videoKey.currentState?.pause();
    } else if (state == AppLifecycleState.resumed) {
      videoKey.currentState?.play();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<VideoDetailViewModel>(
      model: VideoDetailViewModel(),
      onModelInit: (model) => model.loadVideoData(data.id!),
      builder: (context, model, child) {
        return _scaffold(model);
      },
    );
  }

  Widget _scaffold(VideoDetailViewModel model) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          //状态栏
          AnnotatedRegion(
            child: _statusBar(),
            value: SystemUiOverlayStyle.light,
          ),
          Hero(
              tag: '${data.id}${data.time}',
              child: VideoPlayWidget(
                key: videoKey,
                url: data.playUrl!,
              )),
          Expanded(
              flex: 1,
              child: LoadingStateWidget(
                  loadingState: model.loadingState,
                  retry: model.retry,
                  child: Container(
                    //背景色
                    decoration: _decoration(),
                    child: CustomScrollView(
                      slivers: <Widget>[
                        _sliverToBoxAdapter(),
                        _sliverList(model),
                      ],
                    ),
                  )))
        ],
      ),
    );
  }

  _statusBar() {
    return Container(
      height: MediaQuery.of(context).padding.top,
      color: Colors.black,
    );
  }

  _decoration() {
    return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: cachedNetworkImageProvider(
            '${data.cover!.blurred!}}/thumbnail/${MediaQuery.of(context).size.height}x${MediaQuery.of(context).size.width}'),
      ),
    );
  }

  _sliverToBoxAdapter() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _videoTitle(),
          _videoTime(),
          _videoDescription(),
          _videoState(),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              height: 0.5,
              color: Colors.white,
            ),
          ),
          _videoAuthor(),
          const Divider(height: 0.5, color: Colors.white),
        ],
      ),
    );
  }

  _videoTitle() {
    return Padding(
      child: Text(
        data.title!,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      padding: const EdgeInsets.only(left: 10, top: 10),
    );
  }

  _videoTime() {
    return Padding(
      child: Text(
        '#${data.category} / ${formatDateMsByYMDHM(data.author!.latestReleaseTime!)}',
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      padding: const EdgeInsets.only(left: 10, top: 10),
    );
  }

  _videoDescription() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Text(
        data.description!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }

  _videoState() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Row(
        children: <Widget>[
          _row('images/ic_like.png', '${data.consumption!.collectionCount}'),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: _row(
                'images/ic_share_white.png', '${data.consumption!.shareCount}'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: _row(
                'images/icon_comment.png', '${data.consumption!.replyCount}'),
          ),
        ],
      ),
    );
  }

  Widget _row(String image, String text) {
    return Row(
      children: [
        Image.asset(
          image,
          width: 22,
          height: 22,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        )
      ],
    );
  }

  _videoAuthor() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ClipOval(
            child: cacheImage(
              data.author!.icon!,
              width: 40,
              height: 40,
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.author!.name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Padding(
                    child: Text(
                      data.author!.description!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 3)),
              ],
            )),
        Padding(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(5),
              child: const Text(
                MyString.add_follow,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            padding: const EdgeInsets.only(right: 10))
      ],
    );
  }

  _sliverList(VideoDetailViewModel model) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (model.itemList[index].type == VIDEO_SMALL_CARD_TYPE) {
            return VideoItemWidget(
              data: model.itemList[index].data,
              callBack: () {
                Navigator.pop(context);
                toPage(VideoDetailPage(
                  videoDta: model.itemList[index].data,
                ));
              },
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              model.itemList[index].data!.text!,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          );
        },
        childCount: model.itemList.length,
      ),
    );
  }
}
