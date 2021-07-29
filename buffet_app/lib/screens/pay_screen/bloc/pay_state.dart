part of 'pay_bloc.dart';

@immutable
abstract class PayState {}

class PayInitial extends PayState {}

class PayLoaded extends PayState {
  final PayModel model;
  PayLoaded(this.model);
}

class PayError extends PayState {
  final BuffetExceptions message;
  PayError(this.message);
}
