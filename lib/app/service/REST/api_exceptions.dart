import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:movie_catalog_app/config/translations/strings_enum.dart';

class DioExceptions implements Exception {
  String message = "";

  DioExceptions.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = Strings.requestCanceled.tr;
        break;
      case DioExceptionType.connectionTimeout:
        message = Strings.connectionTimeout.tr;
        break;
      case DioExceptionType.receiveTimeout:
        message = Strings.receiveTimeout.tr;
        break;
      case DioExceptionType.sendTimeout:
        message = Strings.sendTimeout.tr;
        break;
      case DioExceptionType.badResponse:
        message = _handleError(dioException.response!.statusCode!.toInt(),
            dioException.response!.data);
        break;
      case DioExceptionType.unknown:
        message = Strings.connectionProblem.tr;
        break;
      default:
        message = Strings.somethingWrong.tr;
        break;
    }
  }

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error['error'] ?? error["message"] ?? Strings.badRequest.tr;
      case 404:
        return error['error'] ?? error["message"] ?? Strings.urlIncorrect.tr;
      case 500:
        return error['error'] ??
            error["message"] ??
            Strings.internalServerError.tr;
      default:
        return error['error'] ?? error["message"] ?? Strings.somethingWrong.tr;
    }
  }

  @override
  String toString() => message;
}
