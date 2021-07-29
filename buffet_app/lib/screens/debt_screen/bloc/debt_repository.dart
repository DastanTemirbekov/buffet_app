import 'package:buffet_app/screens/debt_screen/bloc/debt_provider.dart';
import '../debt_model.dart';

class GetDebtRepository {
  Future<GetDebtModel> getDebt() {
    GetDebtProvider provider = GetDebtProvider();
    return provider.getDebt();
  }


  //   Future<PayDebtModel> postPayDebt(json) {
  //   PayProvider provider = PayProvider();
  //   return provider.postPayDebt(json);
  // }
}

// class PayRepository {
//   Future<PayDebtModel> postPayDebt(json) {
//     PayProvider provider = PayProvider();
//     return provider.postPayDebt(json);
//   }
// }