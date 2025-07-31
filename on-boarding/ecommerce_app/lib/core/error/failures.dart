import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => properties;
} 


//general failures


class ServerFailure extends Failure{
  // final String? message; //if we want some message to give
}

class CacheFailure extends Failure{}