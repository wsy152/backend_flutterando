import 'dart:async';

import 'package:postgres/postgres.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../../dot_env/dot_env_service.dart';
import '../remote_database.dart';

class PostgresDatabase implements RemoteDatabase, Disposable {
  DotEnvService dotEnv;
  PostgresDatabase(this.dotEnv) {
    _init();
  }

  final completer = Completer<PostgreSQLConnection>();



  _init() async {
    final url = dotEnv['DATABASE_URL']!;
    final uri = Uri.parse(url);


    var connection = PostgreSQLConnection(
     uri.host,
      uri.port,
      uri.pathSegments.first,
      username: uri.userInfo.split(':').first,
      password: uri.userInfo.split(':').last,
    );
    await connection.open();
    completer.complete(connection);
  }

  @override
  Future<List<Map<String, Map<String, dynamic>>>> query(String queryText,
      {Map<String, dynamic> variables = const {}}) async {
    final connection = await completer.future;
    return await connection.mappedResultsQuery(queryText,
        substitutionValues: variables);
  }

  @override
  void dispose() async {
    final connection = await completer.future;
    connection.close();
  }
}
