import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../config/translations/strings_enum.dart';
import '../REST/api_exceptions.dart';
import '../graphQL/graphql_service.dart';
import '../helper/dialog_helper.dart';

mixin class ExceptionHandler {
  final GraphQLService graphQLService = GraphQLService();
  RxBool isError = false.obs;

  /// FOR REST API
  void handleError(error) {
    isError.value = true;
    hideLoading();

    var errorText = DioExceptions.fromDioError(error).toString();

    showErrorDialog(Strings.ohNo.tr, errorText);
    Logger().e(errorText);
  }

  /// FOR GRAPHQL API
  void handleGraphqlError(error) {
    isError.value = true;
    hideLoading();
    var errorText = graphQLService.errorMessage.toString();

    try {
      Map onlyMessage = jsonDecode(errorText);
      showErrorDialog(Strings.ohNo.tr, onlyMessage["message"]);
      Logger().e(onlyMessage);
    } catch (e) {
      showErrorDialog(Strings.ohNo.tr, errorText);
      Logger().e(errorText);
    }
  }

  showLoading() {
    isError.value = false;
    DialogHelper.showLoading();
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }

  showErrorDialog(String title, String message) {
    DialogHelper.showErrorDialog(title, message);
  }
}
