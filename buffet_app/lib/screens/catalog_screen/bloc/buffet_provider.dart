import 'package:buffet_app/helpers/api_requester.dart';
import 'package:buffet_app/helpers/buffet_exception.dart';
import 'package:buffet_app/screens/catalog_screen/catalog_model.dart';
import 'package:dio/dio.dart';

class BuffetProvider {
  Future<List<BuffetModels>> getBuffet() async {
    try {
      ApiRequester requester = ApiRequester();
      Response response = await requester.toGet("food/1");
      if (response.statusCode == 200) {
        response.data.map((val) => print(val));
        return response.data.map<BuffetModels>((val) => BuffetModels.fromJson(val)).toList();
      }
      throw BuffetExceptions.catchError(response);
    } catch (e) {
      print(e);
      throw BuffetExceptions.catchError(e);
    }
  }
}


