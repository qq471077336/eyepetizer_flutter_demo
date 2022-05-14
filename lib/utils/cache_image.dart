import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

Widget cacheImage(String url,
    {double? width,
    double? height,
    fit = BoxFit.cover,
    BorderRadius? borderRadius,
    BoxShape shape = BoxShape.rectangle,
    bool clearMemoryCacheWhenDispose = false}) {
  return ExtendedImage.network(
    url,
    shape: shape,
    width: width,
    height: height,
    fit: fit,
    borderRadius: borderRadius,
    clearMemoryCacheWhenDispose: clearMemoryCacheWhenDispose,
  );
}

ImageProvider cachedNetworkImageProvider(String url) {
  return ExtendedNetworkImageProvider(url);
}