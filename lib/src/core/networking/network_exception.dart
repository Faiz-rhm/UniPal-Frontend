// ignore_for_file: constant_identifier_names
import 'package:dio/dio.dart';

/// An enum that holds names for our custom exceptions.
enum _ExceptionType {
  /// The exception for an expired bearer token.
  TokenExpiredException,

  /// The exception for a prematurely cancelled request.
  CancelException,

  /// The exception for a failed connection attempt.
  ConnectTimeoutException,

  /// The exception for failing to send a request.
  SendTimeoutException,

  /// The exception for failing to receive a response.
  ReceiveTimeoutException,

  /// The exception for no internet connectivity.
  SocketException,

  /// A better name for the socket exception.
  FetchDataException,

  /// The exception for an incorrect parameter in a request/response.
  FormatException,

  /// The exception for an unknown type of failure.
  UnrecognizedException,

  /// The exception for an unknown exception from the api.
  ApiException,
}

class NetworkException implements Exception{
  final String name, message;
  final _ExceptionType exceptionType;

  NetworkException({
    String? code,
    required this.message,
    required this.exceptionType,
  }): name = code ?? exceptionType.name;

  factory NetworkException.fromDioException(Exception error) {
    try {
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.cancel:
            return NetworkException(
              exceptionType: _ExceptionType.CancelException,
              message: 'Request cancelled prematurely',
            );
          case DioErrorType.connectTimeout:
            return NetworkException(
              exceptionType: _ExceptionType.ConnectTimeoutException,
              message: 'Connection not established',
            );
          case DioErrorType.sendTimeout:
            return NetworkException(
              exceptionType: _ExceptionType.SendTimeoutException,
              message: 'Failed to send',
            );
          case DioErrorType.receiveTimeout:
            return NetworkException(
              exceptionType: _ExceptionType.ReceiveTimeoutException,
              message: 'Failed to receive',
            );
          case DioErrorType.response:
          case DioErrorType.other:
            if (error.message.contains(_ExceptionType.SocketException.name)) {
              return NetworkException(
                exceptionType: _ExceptionType.FetchDataException,
                message: 'No internet connectivity',
              );
            }
            final name = error.response?.data['headers']['code'] as String;
            final message =
                error.response?.data['headers']['message'] as String;
            if (name == _ExceptionType.TokenExpiredException.name) {
              return NetworkException(
                exceptionType: _ExceptionType.TokenExpiredException,
                message: message,
              );
            }
            return NetworkException(
              exceptionType: _ExceptionType.ApiException,
              message: message,
            );
        }
      } else {
        return NetworkException(
          exceptionType: _ExceptionType.UnrecognizedException,
          message: 'Error unrecognized',
        );
      }
    } on FormatException catch (e) {
      return NetworkException(
        exceptionType: _ExceptionType.FormatException,
        message: e.message,
      );
    } on Exception catch (_) {
      return NetworkException(
        exceptionType: _ExceptionType.UnrecognizedException,
        message: 'Error unrecognized',
      );
    }
  }
}