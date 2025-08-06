import '../../domain/entities/signup_entity.dart';

class SigninModel extends SignupEntity {
  const SigninModel({
    required super.email,
    required super.password,
  }) : super(name: '');

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}