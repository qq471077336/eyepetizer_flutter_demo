import 'package:card_swiper/card_swiper.dart';
import 'package:eyepetizer_flutter_demo/utils/cache_image.dart';
import 'package:eyepetizer_flutter_demo/viewmodel/home/home_page_viewmodel.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  final HomePageViewModel model;

  const BannerWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          //类似FrameLayout
          return Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: cachedNetworkImageProvider(
                      model.bannerList[index].data!.cover!.feed!),
                  fit: BoxFit.cover,
                )),
              ),
              // banner底部透明黑条
              Positioned(
                  width: MediaQuery.of(context).size.width - 30,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                    decoration: const BoxDecoration(color: Colors.black12),
                    child: Text(
                      model.bannerList[index].data!.title!,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )),
            ],
          );
        },
        onTap: (index) {
          print("点击了banner图。。$index}");
        },
        // banner 指示器
        pagination: const SwiperPagination(
            alignment: Alignment.bottomRight,
            builder: DotSwiperPaginationBuilder(
              size: 8,
              activeSize: 8,
              color: Colors.white,
              activeColor: Colors.white24,
            )),
        itemCount: model.bannerList.length);
  }
}
