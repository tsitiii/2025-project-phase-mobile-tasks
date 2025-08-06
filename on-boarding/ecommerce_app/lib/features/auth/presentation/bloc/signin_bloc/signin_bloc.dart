import 'package:flutter_bloc/flutter_bloc.dart';

import 'signin_event.dart';
import 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(const SigninFormState(isPasswordVisible: false)) {
    on<SigninSubmitted>(_onSigninSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  Future<void> _onSigninSubmitted(
    SigninSubmitted event,
    Emitter<SigninState> emit,
  ) async {
    emit(SigninLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Add your actual signin API call here
      // final result = await authRepository.signIn(
      //   email: event.email,
      //   password: event.password,
      // );

      emit(const SigninSuccess(message: "Welcome! Sign in successful"));
    } catch (error) {
      emit(SigninError(message: error.toString()));
    }
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<SigninState> emit,
  ) {
    final currentState = state;
    if (currentState is SigninFormState) {
      emit(
        currentState.copyWith(
          isPasswordVisible: !currentState.isPasswordVisible,
        ),
      );
    } else {
      emit(const SigninFormState(isPasswordVisible: true));
    }
  }
}
