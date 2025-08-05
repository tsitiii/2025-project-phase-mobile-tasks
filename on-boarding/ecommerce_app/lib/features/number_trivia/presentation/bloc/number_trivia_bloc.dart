
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_random_num_trivia.dart';
import '../../domain/usecases/get_concrete_num_trivia.dart';
import 'number_trivai_state.dart';
import 'number_trivia_event.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTrivaiState> {
  final GetConcreteNUmberTrivia getConcreteNUmberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;

  NumberTriviaBloc({
    required GetConcreteNUmberTrivia concrete,
    required GetRandomNumberTrivia random,
  })  : getConcreteNUmberTrivia = concrete,
        getRandomNumberTrivia = random,
        super(Empty());


  @override
  Stream<NumberTrivaiState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {

  }
}