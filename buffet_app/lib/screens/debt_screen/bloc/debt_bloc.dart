import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buffet_app/helpers/buffet_exception.dart';
import 'package:buffet_app/screens/debt_screen/bloc/debt_repository.dart';
import 'package:buffet_app/screens/debt_screen/debt_model.dart';
import 'package:meta/meta.dart';

part 'debt_event.dart';
part 'debt_state.dart';

class DebtBloc extends Bloc<DebtEvent, DebtState> {
  GetDebtRepository repository = GetDebtRepository();
  DebtBloc(this.repository) : super(GetDebtInitial());

  @override
  Stream<DebtState> mapEventToState(
    DebtEvent event,
  ) async* {
    if (event is GetDebtEvent) {
      try {
        GetDebtInitial();
        
        GetDebtModel data = await repository.getDebt();
        yield GetDebtLoaded(data);
      } catch (e) {
        yield GetDebtError(BuffetExceptions.catchError(e));
      }
    }
  }
}
