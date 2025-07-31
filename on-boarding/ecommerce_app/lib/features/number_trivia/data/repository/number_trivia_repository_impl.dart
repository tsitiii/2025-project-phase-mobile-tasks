import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/number_trivia/domain/repository/number_trivia_repo.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../datasources/number_trivia_local_datasource.dart ';
import '../datasources/number_trivia_remote_datasource.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository{

  Future<Either<Failure,NumberTrivia>> getConcreteNUmberTrivia(dynamic num){
    final NumberTriviaLocalDatasource localDatasource;
    final NumberTriviaRemoteDatasource remoteDatasource;
    final NetworkInfo networkInfo;
    
  }

  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia(){
    return null;
  }
}