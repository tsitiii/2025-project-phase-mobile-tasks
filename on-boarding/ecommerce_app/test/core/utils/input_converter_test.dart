

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  late InputConverter inputConverter;
  setUp((){
    inputConverter = InputConverter();
  });

  group("test", ()async{
    test("should return integer when string represents unsigned integer", ()async{
      //arrange
      final str = '123';
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Right(123));
    });

    test("should return a failure when string is not iteger", ()async{
        final str = 'abc';
        final result = inputConverter.stringToUnsignedInteger(str);
        expect(result, Left(InvalidInputFailure()));
    });

    test("should return a failure when string is not iteger", ()async{
        final str = '-123';
        final result = inputConverter.stringToUnsignedInteger(str);
        expect(result, Left(InvalidInputFailure()));
    });
  });
}