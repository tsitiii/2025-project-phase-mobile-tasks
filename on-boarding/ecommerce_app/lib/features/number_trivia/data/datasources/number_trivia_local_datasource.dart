
import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDatasource {
  Future<NumberTriviaModel> getLastnumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}