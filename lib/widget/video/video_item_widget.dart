import 'package:eyepetizer_flutter_demo/model/common_item.dart';
import 'package:eyepetizer_flutter_demo/utils/cache_image.dart';
import 'package:eyepetizer_flutter_demo/utils/date_util.dart';
import 'package:flutter/material.dart';

class VideoItemWidget extends StatelessWidget {
  final Data? data;

  // 点击回调方法
  final VoidCallback? callBack;

  // 是否开启hero动画，默认为false
  final bool openHero;
  final Color titleColor;
  final Color categoryColor;

  const VideoItemWidget(
      {Key? key,
      this.data,
      this.callBack,
      this.titleColor = Colors.white,
      this.categoryColor = Colors.white,
      this.openHero = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Row(
          children: [
            // 左边图片显示设置
            _videoImage(),
            // 右边文字显示设置
            _videoText(),
          ],
        ),
      ),
    );
  }

  _videoImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: _coverWidget(),
        ),
        Positioned(
          right: 5,
          bottom: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(color: Colors.white54),
              child: Text(
                formatDateMsByMS(data!.duration! * 1000),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _videoText() {
    return Expanded(
      flex: 1,
      child: Padding(padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
          data!.title!,
          style: TextStyle(
              color: titleColor, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            '#${data!.category} / ${data!.author?.name}',
            style: TextStyle(color: categoryColor, fontSize: 12),
          ),
        ),
      ],),),
    );
  }

  _coverWidget() {
    if (openHero) {
      return Hero(
        tag: '${data?.id}${data?.time}',
        child: _imageWidget(),
      );
    }
    return _imageWidget();
  }

  _imageWidget() {
    return cacheImage(
      data!.cover!.detail!,
      width: 135,
      height: 80,
    );
  }
}
