import 'package:dio/dio.dart';

import 'buffet_exception.dart';

class ApiRequester {
  static String url = "https://easyitselfcheck.herokuapp.com/api/v1/";

  Future<Dio> initDio() async {
    return Dio(BaseOptions(
      baseUrl: url,
      responseType: ResponseType.json,
      receiveTimeout: 10000,
      connectTimeout: 10000,
    ));
  }

  Future<Response> toGet(String url, {Map<String, dynamic>? param}) async {
    Dio dio = await initDio();
    try {
      return dio.get(url, queryParameters: param);
    } catch (e) {
      print(e);
      throw BuffetExceptions.catchError(e);
    }
  }

  Future<Response> toPost(String url, json) async {
    Dio dio = await initDio();
    try {
      return await dio.post(url, data: json); //data: dataParam,
    } catch (e) {
      throw BuffetExceptions.catchError(e);
    }
  }
}
