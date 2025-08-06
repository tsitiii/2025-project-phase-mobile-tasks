

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/signup_entity.dart';

abstract class SigninRepository {
  Future<Either<Failure,String>> signin(SignupEntity credentials);
}