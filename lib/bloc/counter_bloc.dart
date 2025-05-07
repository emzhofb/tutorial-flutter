import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<IncrementCounterRequested>(_onIncrementCounter);
  }

  Future<void> _onIncrementCounter(
    IncrementCounterRequested event,
    Emitter<CounterState> emit,
  ) async {
    emit(CounterSuccess(event.counter + 1));
  }
}
