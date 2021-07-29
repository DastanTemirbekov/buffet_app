part of 'buffet_bloc.dart';

@immutable
abstract class BuffetState {}

//class BuffetInitial extends BuffetState {}
class BuffetLoading extends BuffetState {}

class BuffetLoaded extends BuffetState {
  final List<BuffetModels> model;
  BuffetLoaded(this.model);
}

class BuffetError extends BuffetState {
  final BuffetExceptions message;
  BuffetError(this.message);
}
