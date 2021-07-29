part of 'pay_bloc.dart';

@immutable
abstract class PayEvent {}

class PostPayEvent extends PayEvent{
  final String pin;
  final int payment;
  final List<BuffetModels>? card;
  PostPayEvent(this.pin, this.payment, this.card);
}