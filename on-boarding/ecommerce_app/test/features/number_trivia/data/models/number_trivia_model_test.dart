import 'dart:convert';

import 'package:ecommerce_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:ecommerce_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../Fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: "test text");

  test("Testing number trivia models", () async {
    //arrange

    //act

    //assert
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group("from json impelementation", () async {
    test(
      "should return valid model when the json object is an integer",
      () async {
        //arrange
        final Map<String, dynamic> jsonmap = json.decode(
          fixture("trivia.json"),
        );

        //act
        final result = NumberTriviaModel.fromJson(jsonmap);

        //assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      "should return valid model when the json object is an integer",
      () async {
        //arrange
        final Map<String, dynamic> jsonmap = json.decode(
          fixture("trivia_double.json"),
        );

        //act
        final result = NumberTriviaModel.fromJson(jsonmap);

        //assert
        expect(result, equals(tNumberTriviaModel));
      },
    );
  });
}
