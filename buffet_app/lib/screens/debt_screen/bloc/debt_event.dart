part of 'debt_bloc.dart';

@immutable
abstract class DebtEvent {}

class GetDebtEvent extends DebtEvent{
  GetDebtEvent();
}
// class PayDebtEvent extends DebtEvent{
//   final String pin;
//   final int money;
//   PayDebtEvent(this.pin, this.money);
// }

