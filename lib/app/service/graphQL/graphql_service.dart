import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

import 'graphql_config.dart';

class GraphQLService extends GetxService {
  GraphQLConfig graphQLConfig = GraphQLConfig();
  String errorMessage = "";

  /// QUERY
  Future<dynamic> performQuery(String query) async {
    final queryOptions = QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
    );

    final result = await graphQLConfig.graphqlClient().query(queryOptions);

    _checkException(result);

    return result.data;
  }

  /// MUTATION
  Future<dynamic> performMutation(String mutation) async {
    final mutationOptions = MutationOptions(
      document: gql(mutation),
      fetchPolicy: FetchPolicy.networkOnly,
    );

    final result = await graphQLConfig.graphqlClient().mutate(mutationOptions);
    _checkException(result);
    return result.data;
  }

  /// MUTATION WITH SINGLE FILE

  Future<dynamic> performFileUpload(
      {required String mutation, required String key, File? file}) async {
    if (file == null) {
      throw Exception('No file provided');
    }

    final fileBytes = await file.readAsBytes();
    final multipartFile = http.MultipartFile.fromBytes(
      key,
      fileBytes,
      filename: file.path.split('/').last,
    );

    final options = MutationOptions(
      document: gql(mutation),
      variables: {
        key: multipartFile,
      },
    );

    final result = await graphQLConfig.graphqlClient().mutate(options);
    _checkException(result);
    return result.data;
  }

  ///MUTATION WITH MULTIPLE FILE

  Future<dynamic> performMultipleFileUpload({
    required String mutation,
    required Map<String, File> files,
  }) async {
    final Map<String, http.MultipartFile> multipartFiles = {};

    files.forEach((key, file) async {
      final fileBytes = await file.readAsBytes();
      final multipartFile = http.MultipartFile.fromBytes(
        key,
        fileBytes,
        filename: file.path.split('/').last,
      );
      multipartFiles[key] = multipartFile;
    });

    final variables = <String, dynamic>{};
    multipartFiles.forEach((key, multipartFile) {
      variables[key] = multipartFile;
    });

    final options = MutationOptions(
      document: gql(mutation),
      variables: variables,
    );

    final result = await graphQLConfig.graphqlClient().mutate(options);
    _checkException(result);
    return result.data;
  }

  /// ERROR CHECKER
  _checkException(result) {
    if (result.hasException) {
      final List<GraphQLError> errors = result.exception!.graphqlErrors;
      final LinkException? linkException = result.exception!.linkException;
      if (errors.isNotEmpty) {
        for (final GraphQLError error in errors) {
          errorMessage = error.message.toString();

          throw error.message;
        }
      } else if (linkException != null) {
        if (linkException.originalException is TimeoutException) {
          errorMessage = "Request timed out!";
        } else {
          errorMessage = linkException.originalException.toString() != "null"
              ? linkException.originalException.toString()
              : "Something went wrong!";
          throw linkException.originalException!;
        }
      }
    }
  }
}
