import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:ecommerce_app/features/number_trivia/domain/repository/number_trivia_repo.dart';
import 'package:ecommerce_app/features/number_trivia/domain/usecases/get_concrete_num_trivia.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// ✅ Manual mock implementation
class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNUmberTrivia(dynamic number) =>
      super.noSuchMethod(
        Invocation.method(#getConcreteNUmberTrivia, [number]),
        returnValue: Future.value(Right(NumberTrivia(text: "test", number: 1))),
      );
}

void main() {
  late GetConcreteNUmberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  
  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNUmberTrivia(mockNumberTriviaRepository);
  });
  
  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(text: "test", number: 1);
  
  test(
    'should get trivia number from repository',
    () async {
      // Arrange
      when(mockNumberTriviaRepository.getConcreteNUmberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      
      // Act
      final result = await usecase.execute(tNumber);
      
      // Assert
      expect(result, Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNUmberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}