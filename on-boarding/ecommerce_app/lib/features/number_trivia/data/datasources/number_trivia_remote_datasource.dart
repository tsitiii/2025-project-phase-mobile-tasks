import 'package:ecommerce_app/features/number_trivia/domain/repository/number_trivia_repo.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/number_trivia.dart';


abstract class NumberTriviaRemoteDatasource {
  Future<NumberTrivia> getConcreteNUmberTrivia(dynamic, number);

  Future<NumberTrivia> getRandomNumberTrivia();
}