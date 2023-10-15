import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message ?? '';
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Seems you have connection issue',
  });

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'NetworkFailure($message)';
}

class ClientFailure extends Failure {
  const ClientFailure({
    super.message = 'Seems you have a problem',
  });

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'ClientFailure($message)';
}

class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Server Error',
    this.errorType = 'Server Error',
    this.statusCode,
  });

  final String errorType;
  final int? statusCode;

  @override
  List<Object?> get props => [
        message,
        errorType,
        statusCode,
      ];

  @override
  String toString() => 'ServerFailure($statusCode, $errorType, $message)';
}
