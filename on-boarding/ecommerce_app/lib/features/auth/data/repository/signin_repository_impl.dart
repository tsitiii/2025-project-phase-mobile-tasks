import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/signup_entity.dart';
import '../../domain/repository/signin_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';

class SigninRepositoryImpl implements SigninRepository {
  final UserLocalDatasource userLocalDatasource;
  final UserRemoteDatasource userRemoteDatasource;
  final NetworkInfo networkInfo;

  SigninRepositoryImpl({
    required this.userLocalDatasource,
    required this.userRemoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> signin(SignupEntity credentials) async {
    print('🏪 SigninRepository: signin method called');
    print('🏪 SigninRepository: Email: ${credentials.email}');

    // ✅ Debug network connectivity
    print('📡 SigninRepository: Checking network connectivity...');
    try {
      final isConnected = await networkInfo.isConnected;
      print('📡 SigninRepository: Network connected: $isConnected');

      if (!isConnected) {
        print('❌ SigninRepository: No network connection detected');
        return const Left(
          NetworkFailure(
            message:
                'No internet connection. Please check your network and try again.',
          ),
        );
      }
    } catch (networkError) {
      print('SigninRepository: Network check failed: $networkError');
      // Continue anyway - maybe network check is broken but internet works
    }

    try {
      final userModel = UserModel(
        name: '', // Empty for signin
        email: credentials.email,
        password: credentials.password,
      );
      final accessToken = await userRemoteDatasource.signIn(userModel);
      try {
        await userLocalDatasource.saveToken(accessToken);
      } catch (cacheError) {
        print(
          'SigninRepository: Token storage warning (non-critical): $cacheError',
        );
      }

      print('🎉 SigninRepository: Signin process completed successfully!');
      return Right(accessToken);
    } on SocketException catch (e) {
      print('SigninRepository: SocketException details: $e');
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

      if (errorMessage.contains('network error') ||
          errorMessage.contains('connection') ||
          errorMessage.contains('timeout') ||
          errorMessage.contains('socket')) {
        return const Left(
          NetworkFailure(
            message: 'Connection problem. Please check your internet.',
          ),
        );
      } else if (errorMessage.contains('invalid credentials') ||
          errorMessage.contains('unauthorized') ||
          errorMessage.contains('sign in failed') ||
          errorMessage.contains('login failed') ||
          errorMessage.contains('authentication failed')) {
        return const Left(
          ServerFailure(
            message:
                'Invalid email or password. Please check your credentials.',
          ),
        );
      } else if (errorMessage.contains('user not found') ||
          errorMessage.contains('account not found')) {
        return const Left(
          ServerFailure(
            message: 'Account not found. Please check your email or sign up.',
          ),
        );
      } else {
        return const Left(
          ServerFailure(message: 'Login failed. Please try again.'),
        );
      }
    }
  }
}
