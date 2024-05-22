import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink("https://countries.trevorblades.com");

  final AuthLink authLink = AuthLink(
    getToken: () async {
      //  String token = await MySharedPref.getToken() ?? "";
      //  return "JWT $token";
      return "JWT token";
    },
    headerKey: "Authorization",
  );

  GraphQLClient graphqlClient() => GraphQLClient(
        cache: GraphQLCache(),
        link: authLink.concat(httpLink),
      );
}
