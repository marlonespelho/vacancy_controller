import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parking_controller/core/http/http_service.dart';

class DioInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Exception? exception;

    int? statusCode = err.response?.statusCode;
    var errorMessage = err.response?.data?["message"] ?? err.response?.data?['errors']['json'];
    if (statusCode != null) {
      exception = {
        400: BadRequestException(
          statusCode: err.response?.statusCode,
          serverError: errorMessage,
        ),
        401: UnauthorizedException(
          statusCode: err.response?.statusCode,
          serverError: errorMessage,
        ),
        404: NotFoundException(
          statusCode: err.response?.statusCode,
          serverError: errorMessage,
        ),
        422: UnprocessableEntityException(
          statusCode: err.response?.statusCode,
          serverError: errorMessage,
        ),
        500: (err.message != null && err.message!.toString().contains("401"))
            ? UnauthorizedException(
                statusCode: err.response?.statusCode,
                serverError: errorMessage,
              )
            : InternalServerError(
                statusCode: err.response?.statusCode,
                serverError: errorMessage,
              ),
        522: TimeOutException(
          statusCode: err.response?.statusCode,
          serverError: errorMessage,
        ),
      }[statusCode];
    }

    exception ??= {
      DioExceptionType.connectionError: NoConnectionException(
        statusCode: err.response?.statusCode,
        serverError: errorMessage,
      ),
      DioExceptionType.connectionTimeout: TimeOutException(
        statusCode: err.response?.statusCode,
        serverError: errorMessage,
      ),
      DioExceptionType.receiveTimeout: TimeOutException(
        statusCode: err.response?.statusCode,
        serverError: errorMessage,
      ),
      DioExceptionType.sendTimeout: TimeOutException(
        statusCode: err.response?.statusCode,
        serverError: errorMessage,
      ),
      DioExceptionType.unknown: UnexpectedException(
        statusCode: err.response?.statusCode,
        serverError: errorMessage,
      ),
    }[err.type];

    if (err.error is SocketException) {
      exception = NoConnectionException();
    }

    exception ??= UnexpectedException(
      statusCode: err.response?.statusCode,
      serverError: err.response?.data['errors']['json'],
    );
    throw exception;
  }
}
