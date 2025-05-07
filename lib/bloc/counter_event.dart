part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class IncrementCounterRequested extends CounterEvent {
  final int counter;

  const IncrementCounterRequested(this.counter);
}
