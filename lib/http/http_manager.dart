import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpManager {
  static Utf8Decoder utf8decoder = const Utf8Decoder();

  static void getData(String url,
      {Map<String, String>? headers,
      required Function success,
      required Function fail,
      Function? complete}) async {
    var response = await http.get(Uri.parse(url), headers: headers);
    try {
      if (response.statusCode == 200) {
        var result = json.decode(utf8decoder.convert(response.bodyBytes));
        success(result);
      }
    } catch (e) {
      fail(e);
    } finally {
      if (complete != null) {
        complete();
      }
    }
  }

  static Future requestData(
    String url, {
    Map<String, String>? headers,
  }) async {
    var response = await http.get(Uri.parse(url), headers: headers);
    try {
      if (response.statusCode == 200) {
        var result = json.decode(utf8decoder.convert(response.bodyBytes));
        return result;
      } else {
        throw Exception('"Request failed with status: ${response.statusCode}"');
      }
    } catch (e) {
      Future.error(e);
    }
  }
}
