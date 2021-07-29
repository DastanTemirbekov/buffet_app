import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:buffet_app/helpers/buffet_exception.dart';
import 'package:buffet_app/screens/catalog_screen/catalog_model.dart';
//import 'package:buffet_app/model/buffet_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'buffet_repository.dart';

part 'buffet_event.dart';
part 'buffet_state.dart';

class BuffetBloc extends Bloc<BuffetEvent, BuffetState> {
  BuffetRepository repository = BuffetRepository();

  BuffetBloc(this.repository) : super(BuffetLoading());

  Stream<BuffetState> mapEventToState(
    BuffetEvent event,
  ) async* {
    if (event is GetBuffetEvent) {
      try {
        yield BuffetLoading();
        List<BuffetModels> data = await repository.getBuffet();
        yield BuffetLoaded(data);
        //print(data);
      } catch (e) {
        yield BuffetError(BuffetExceptions.catchError(e));
      }
    }
    //  else if (event is MakePaymentEvent) {
    //   try {
    //     MakePaymentModel data = await repository.postBuffet(event.pin, event.payment);
    //     yield MakePaymentLoaded(data);
    //     //print(data);
    //   } catch (e) {
    //     yield BuffetError(BuffetExceptions.catchError(e));
    //   }
    // }
  }
}

// class GetDebtBloc extends Bloc<GetDebtEvent, GetDebtState> {
//   GetDebtRepository repository = GetDebtRepository();
//   GetDebtBloc(this.repository) : super(GetDebtLoading());

//   @override
//   Stream<GetDebtState> mapEventToState(
//     GetDebtEvent event,
//   ) async* {
//     try {
//       if (event is GetDebtEvent) {
//         yield GetDebtLoading();
//         GetDebtModel data = await repository.getDebt(event.pin);
//         yield GetDebtLoaded(data);
//       }
//     } catch (e) {
//       yield GetDebtError(BuffetExceptions.catchError(e));
//     }
//   }
// }



// class CounterBloc extends Bloc<CounterEvent, CounterState> {
//   CounterBloc() : super(CounterState(counter: 0));

//   @override
//   Stream<CounterState> mapEventToState(
//     CounterEvent event,
//   ) async* {
//     else if (event is AddEvent) {
//       yield CounterState(counter: state.counter! + 1);
//     } else if (event is RemoveEvent) {
//       yield CounterState(counter: state.counter! - 1);
//     }
//   }
// }

// class BuffetBloc2 extends Bloc<BuffetEvent2, BuffetState2> {
//   BuffetRepository2 repository = BuffetRepository2();

//   BuffetBloc2(this.repository) : super(BuffetDebtsLoaded());

//   Stream<BuffetState2> mapEventToState(
//     BuffetEvent2 event,
//   ) async* {
//     if (event is GetDebtsEvent) {
//         BuffetModels2 data = await repository.getBuffet();
//         yield BuffetDebtsLoaded(data);
//       } catch (e) {
//         yield BuffetError2(BuffetExceptions.catchError(e));
//       }
//     }
//   }
