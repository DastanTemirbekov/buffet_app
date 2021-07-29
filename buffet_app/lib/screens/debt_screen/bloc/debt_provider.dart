import 'package:buffet_app/helpers/api_requester.dart';
import 'package:buffet_app/helpers/buffet_exception.dart';
import 'package:dio/dio.dart';
import '../debt_model.dart';

class GetDebtProvider {
  Future<GetDebtModel> getDebt() async {
    try {
      ApiRequester requester = ApiRequester();
      Response response = await requester.toGet("operation/detail/634232");
      if (response.statusCode == 200) {
        return GetDebtModel.fromJson(response.data);
      }
      throw BuffetExceptions.catchError(response);
    } catch (e) {
      print(e);
      throw BuffetExceptions.catchError(e);
    }
  }
}

class PayProvider {
  Future<PayDebtModel> postPayDebt(json) async {
    print(json);
    try {
      ApiRequester requester = ApiRequester();
      Response response = await requester.toPost("pin/make/payment", json);
      if (response.statusCode == 200) {
        return PayDebtModel.fromJson(response.data);
      }
    //  else if (response.statusCode == 404) {
    //     return BuffetExceptions.catchError(e);
    //   }

      throw BuffetExceptions.catchError(response);
    } catch (e) {
      print(e);
      throw BuffetExceptions.catchError(e);
    }
  }
}

