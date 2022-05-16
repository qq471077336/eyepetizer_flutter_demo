import 'package:eyepetizer_flutter_demo/model/common_item.dart';
import 'package:eyepetizer_flutter_demo/utils/cache_image.dart';
import 'package:eyepetizer_flutter_demo/utils/date_util.dart';
import 'package:eyepetizer_flutter_demo/utils/share_util.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final Item item;
  final bool showCategory;

  const ListItemWidget({Key? key, required this.item, this.showCategory = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //垂直方向的LinearLayout
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print('点击跳转详情页');
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Stack(
              children: <Widget>[
                _clipRRectImage(context),
                _categoryText(),
                _videoTime(),
              ],
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Row(
            children: <Widget>[
              _authorHeaderImage(item),
              _videoDescription(),
              _shareButton(),
            ],
          ),
        )
      ],
    );
  }

  ///封面
  _clipRRectImage(BuildContext context) {
    //圆角
    return ClipRRect(
      //tag相同的两个widget自动关联动画
      child: Hero(
          tag: '${item.data?.id}${item.data?.time}',
          child: cacheImage(item.data!.cover!.feed!,
              width: MediaQuery.of(context).size.width, height: 200)),
      borderRadius: BorderRadius.circular(4),
    );
  }

  ///图片左上角显示的视频分类
  _categoryText() {
    return Positioned(
      child: Opacity(
        opacity: showCategory ? 1.0 : 0,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.all(Radius.circular(22)),
          ),
          width: 44,
          height: 44,
          alignment: AlignmentDirectional.center,
          child: Text(
            item.data!.category!,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
      left: 15,
      top: 10,
    );
  }

  _videoTime() {
    return Positioned(
        right: 15,
        bottom: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white54),
            padding: const EdgeInsets.all(5),
            child: Text(
              formatDateMsByMS(item.data!.duration! * 1000),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }

  ///作者头像
  _authorHeaderImage(Item item) {
    //椭圆
    return ClipOval(
      clipBehavior: Clip.antiAlias,
      child: cacheImage(
        item.data?.author == null
            ? item.data!.author!.icon!
            : item.data!.provider!.icon!,
        width: 40,
        height: 40,
      ),
    );
  }

  _videoDescription() {
    //相当于Android设置weight权重
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item.data!.title!,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                item.data?.author == null
                    ? item.data!.description!
                    : item.data!.author!.name!,
                style: const TextStyle(color: Color(0xff9a9a9a), fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  _shareButton() {
    return IconButton(
      onPressed: () => share(item.data!.title!, item.data!.playUrl!),
      icon: const Icon(
        Icons.share,
        color: Colors.black38,
      ),
    );
  }
}
