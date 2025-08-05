import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/number_trivia.dart';

@immutable
abstract class NumberTrivaiState extends Equatable {
  const NumberTrivaiState();

  @override
  List<Object?> get props => [];
}
class Empty extends NumberTrivaiState{

}

class Loading extends NumberTrivaiState{

}
class Loaded extends NumberTrivaiState{
  final NumberTrivia trivia;
  const Loaded({
    required this.trivia
  });

  @override
  List<Object?> get props => [trivia];
}

class Error extends NumberTrivaiState{
  final String message;
 const Error({
    required this.message
  });
  @override
  List<Object> get props => [message];
}