
import 'package:equatable/equatable.dart';

abstract class SigninState  extends Equatable{
  const SigninState();
  @override
  List<Object>get props => [];

}

class SigninLoading extends SigninState{}

class SigninSuccess extends SigninState{
  final String message;
  const SigninSuccess({
    required this.message
  });
}

class SigninError extends SigninState{
  final String message;
  const SigninError({
    required this.message
  });
}

class SigninFormState extends SigninState{
  final bool isPasswordVisible;
  const SigninFormState({
    required this.isPasswordVisible
  });

  SigninFormState copyWith({
    bool? isPasswordVisible
  }){
    return SigninFormState(isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible);
  }
  @override
  List<Object> get props => [isPasswordVisible,];
}
