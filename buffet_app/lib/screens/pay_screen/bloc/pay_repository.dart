import 'package:buffet_app/screens/pay_screen/bloc/pay_provider.dart';
import '../pay_model.dart';

class PayRepository {
  Future<PayModel> postPay(json) {
    PayProvider provider = PayProvider();
    return provider.postPay(json);
  }
}
