import 'package:flutter/material.dart';
import 'package:get/get.dart';

void toPage(Widget page, {bool opaque = false}) {
  Get.to(()=>page, opaque: opaque);
}

void toNamed(String name, dynamic arguments) {
  Get.toNamed(name, arguments: arguments);
}

void back() => Get.back();

dynamic arguments() => Get.arguments;