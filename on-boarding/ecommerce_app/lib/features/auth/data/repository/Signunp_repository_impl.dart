import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/signup_entity.dart';
import '../../domain/repository/signup_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';

class SignupRepositoryImpl implements SignupRepository {
  final UserLocalDatasource userLocalDatasource;
  final UserRemoteDatasource userRemoteDatasource;
  final NetworkInfo networkInfo;

  SignupRepositoryImpl({
    required this.userLocalDatasource,
    required this.userRemoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> signup(SignupEntity user) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return const Left(
        NetworkFailure(
          message:
              'No internet connection. Please check your network and try again.',
        ),
      );
    }

    try {
      final userModel = UserModel(
        name: user.name,
        email: user.email,
        password: user.password,
      );
      final result = await userRemoteDatasource.signUp(userModel);
      try {
        await userLocalDatasource.cacheUser(result);
      } catch (cacheError) {
        print('⚠️ Repository: Cache warning (non-critical): $cacheError');
      }
      return const Right(null);
    } on SocketException catch (e) {
      return const Left(
        NetworkFailure(
          message: 'Connection failed. Please check your internet connection.',
        ),
      );
    } on HttpException catch (e) {
      return const Left(
        NetworkFailure(message: 'Network request failed. Please try again.'),
      );
    } on FormatException catch (e) {
      return const Left(
        ServerFailure(
          message: 'Invalid response from server. Please try again.',
        ),
      );
    } catch (e) {
      final errorMessage = e.toString().toLowerCase();
      print(' Repository: Lowercase error message: $errorMessage');

      if (errorMessage.contains('network error') ||
          errorMessage.contains('connection') ||
          errorMessage.contains('timeout') ||
          errorMessage.contains('socket')) {
        print('Repository: Classified as network error');
        return const Left(
          NetworkFailure(
            message: 'Connection problem. Please check your internet.',
          ),
        );
      } else if (errorMessage.contains('email already exists') ||
          errorMessage.contains('already registered')) {
        return const Left(
          ServerFailure(
            message:
                'Email address is already registered. Please use a different email.',
          ),
        );
      } else if (errorMessage.contains('invalid email')) {
        print('Repository: Classified as invalid email error');
        return const Left(
          ServerFailure(message: 'Please provide a valid email address.'),
        );
      } else if (errorMessage.contains('password')) {
        return const Left(
          ServerFailure(
            message: 'Password does not meet security requirements.',
          ),
        );
      } else {
        return const Left(
          ServerFailure(message: 'Account creation failed. Please try again.'),
        );
      }
    }
  }
}
