import 'package:buffet_app/helpers/api_requester.dart';
import 'package:buffet_app/helpers/buffet_exception.dart';
import 'package:buffet_app/screens/pay_screen/bloc/pay_bloc.dart';
import 'package:dio/dio.dart';
import '../pay_model.dart';

class PayProvider {
  Future<PayModel> postPay(json) async {
    print(json);
    try {
      ApiRequester requester = ApiRequester();
      Response response = await requester.toPost("operation/append", json);
      if (response.statusCode == 200) {
        return PayModel.fromJson(response.data);
      }
      throw BuffetExceptions.catchError(response);
    } catch (e) {
      print(e);
      throw BuffetExceptions.catchError(e);
    }
  }
}
