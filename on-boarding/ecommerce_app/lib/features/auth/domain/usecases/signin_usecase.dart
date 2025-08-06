
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/signup_entity.dart';
import '../repository/signin_repository.dart';

class SigninUsecase {
  final SigninRepository signinRepository;
  SigninUsecase({required this.signinRepository});

  Future<Either<Failure,String>> call(SignupEntity credentials)async{
    return signinRepository.signin( credentials);
  }
}