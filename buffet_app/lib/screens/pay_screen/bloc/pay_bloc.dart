import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:buffet_app/helpers/buffet_exception.dart';
import 'package:buffet_app/screens/catalog_screen/catalog_model.dart';
import 'package:buffet_app/screens/pay_screen/bloc/pay_repository.dart';
import 'package:buffet_app/screens/pay_screen/pay_model.dart';
import 'package:meta/meta.dart';

part 'pay_event.dart';
part 'pay_state.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  PayRepository repository = PayRepository();
  PayBloc(this.repository) : super(PayInitial());
  //List<BuffetModels>? card;
  @override
  Stream<PayState> mapEventToState(
    PayEvent event,
  ) async* {
    if (event is PostPayEvent) {
      // print(event.card);
      List<Products>? productsList = [];

      for (var product in event.card!) {
        productsList.add(Products(id: product.id, amount: product.quantity));
        // payModel.products?.add(Products(id:product.id, amount: product.quantity));
        // print(product.name);
      }
      PayModel payModel = PayModel(
          money: event.payment, pin: event.pin, products: productsList);
      var json = payModel.toJson();
      // print(json);
      // var response = await repository.postPay(json);
      // print(response);
      // print(payModel.products);
      try {
        yield PayInitial();
        // json = card.toJson();
        PayModel data = await repository.postPay(json);
        yield PayLoaded(data);




        
      } catch (e) {
        yield PayError(BuffetExceptions.catchError(e));
      }
    }
  }
}
