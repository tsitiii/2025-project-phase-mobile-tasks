
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/signup_entity.dart';
import '../repository/signup_repository.dart';

class SignupUsecase {
  final SignupRepository repository;
  SignupUsecase( this.repository);

  Future<Either<Failure, void>> call(SignupEntity user){
    return repository.signup(user);
  }
}