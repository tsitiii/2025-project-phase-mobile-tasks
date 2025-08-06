import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/signin_usecase.dart';
import '../../../domain/entities/signup_entity.dart';
import 'signin_event.dart';
import 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final SigninUsecase signinUsecase;

  SigninBloc({required this.signinUsecase})
      : super(const SigninFormState(isPasswordVisible: false)) {
    on<SigninSubmitted>(_onSigninSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  Future<void> _onSigninSubmitted(
    SigninSubmitted event,
    Emitter<SigninState> emit,
  ) async {
    emit(SigninLoading());
    try {
      final credentials = SignupEntity(
        name: '',
        email: event.email,
        password: event.password,
      );

      final result = await signinUsecase.call(credentials);
      result.fold(
        (failure) {
          emit(SigninError(message: failure.message));
        },
        (token) {
          emit(const SigninSuccess(message: "Welcome! Sign in successful"));
        },
      );

    } catch (error) {
      emit(SigninError(message: "An unexpected error occurred: ${error.toString()}"));
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