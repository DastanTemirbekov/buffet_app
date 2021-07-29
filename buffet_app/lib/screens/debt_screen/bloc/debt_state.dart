part of 'debt_bloc.dart';

@immutable
abstract class DebtState {}

class GetDebtInitial extends DebtState {}
 
 class GetDebtLoaded extends DebtState{
   final GetDebtModel model;
  GetDebtLoaded(this.model);
}

// class PayDebtLoaded extends DebtState {
//   final PayDebtModel model;
//   PayDebtLoaded(this.model);
// }

class GetDebtError extends DebtState {
  final BuffetExceptions message;
  GetDebtError(this.message);
}


