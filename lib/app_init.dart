
import 'package:eyepetizer_flutter_demo/http/url.dart';

class AppInit{

  AppInit._();

  static Future<void> init() async {
    Url.baseUrl = 'http://baobab.kaiyanapp.com/api/';
    print(Url.baseUrl);
    Future.delayed(const Duration(milliseconds: 2000), (){

    });
  }
}