import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repository/user_repository.dart';

class GetCurrentUser {
  final UserRepository repository;

  GetCurrentUser(this.repository);
  Future<Either<Failure, UserEntity>> call() async {
    return await repository.getCurrentUser();
  }
}