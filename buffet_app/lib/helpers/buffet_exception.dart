import 'package:dio/dio.dart';

class BuffetExceptions {
  String? message;

  BuffetExceptions({this.message});

  static BuffetExceptions catchError(dynamic error) {
    if (error is DioError) {
      if (error.type == DioErrorType.connectTimeout) {
        return BuffetExceptions(message: "Время ожидания истекло");
      } else if (error.type == DioErrorType.response) {
        return BuffetExceptions(message: "Ошибка в системе");
      }
      else if(error.response!.statusCode == 404){
        return BuffetExceptions(message: "404");
      }
    } else {
      return BuffetExceptions(message: "Произошла системная ошибка");
    }
    return BuffetExceptions(message: "123");
  }
}
