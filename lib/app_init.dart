
import 'package:eyepetizer_flutter_demo/http/Url.dart';

class AppInit{

  AppInit._();

  static Future<void> init() async {
    Url.baseUrl = 'http://baobab.kaiyanapp.com/api/';
    Future.delayed(const Duration(milliseconds: 2000), (){

    });
  }
}