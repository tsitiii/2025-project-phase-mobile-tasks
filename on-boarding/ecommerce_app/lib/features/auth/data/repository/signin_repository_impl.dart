import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/data/datasources/user_local_datasource.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../domain/repository/signin_repository.dart';
import '../../../../core/network/network_info.dart';

class SigninRepositoryImpl implements SigninRepository {
  final UserLocalDatasource userLocalDatasource;
  final UserRemoteDatasource userRemoteDatasource;
  final NetworkInfo networkInfo;

  SigninRepositoryImpl({
    required this.userLocalDatasource,
    required this.userRemoteDatasource,
    required this.networkInfo,
  });

  Future<Either<Failure,String>> signin()async{
        final isConnected = await networkInfo.isConnected;
        if(!await isConnected){
          return Left(NetworkFailure(message: "No internet"));
        }

        try {
          
        } catch (e) {
          
        }
  }
}