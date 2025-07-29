import '../../../../core/error/failures.dart';
import '../entities/number_trivia.dart';
import '../repository/number_trivia_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GetConcreteNUmberTrivia {
  final NumberTriviaRepository repository;
  GetConcreteNUmberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> execute ( @required int number)async{
      return await repository.getConcreteNUmberTrivia(number);
  }
}