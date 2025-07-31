import 'dart:convert';

import 'package:meta/meta.dart';

import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  
  NumberTriviaModel({
    @required super.number,
    @required super.text});

    factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
      return NumberTriviaModel(
        number: (json['number']as num).toInt(),
        text: json['text']);
    }
}
  