import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/number_trivia/domain/repository/number_trivia_repo.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../datasources/number_trivia_local_datasource.dart';
import '../datasources/number_trivia_remote_datasource.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository{
    final NumberTriviaLocalDatasource localDatasource;
    final NumberTriviaRemoteDatasource remoteDatasource;
    final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
      required this.localDatasource,
      required this.remoteDatasource,
      required this.networkInfo,
    });

  Future<Either<Failure,NumberTrivia>> getConcreteNUmberTrivia(dynamic num) async {
   

    return Future.value(Left(ServerFailure()));
  }

  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {

    return Future.value(Left(ServerFailure()));
  }
}