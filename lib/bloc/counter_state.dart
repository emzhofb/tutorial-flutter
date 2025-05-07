part of 'counter_bloc.dart';

class CounterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CounterInitial extends CounterState {}

class CounterSuccess extends CounterState {
  final int value;

  CounterSuccess(this.value);

  @override
  List<Object?> get props => [value];
}
