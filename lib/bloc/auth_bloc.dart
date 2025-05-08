import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatbot/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final response = await authRepository.login(
        event.username,
        event.password,
      );

      emit(AuthSuccess(response.token));
    } on AuthFailure catch (e) {
      emit(AuthFailure(e.error));
    } catch (e) {
      emit(AuthFailure("Unexpected error occurred"));
    }
  }
}
