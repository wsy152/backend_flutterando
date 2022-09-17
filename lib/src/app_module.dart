import 'package:backend_flutterando/src/cores/services/dot_env/dot_env_service.dart';
import 'package:backend_flutterando/src/database/postgres/postgres_database.dart';
import 'package:backend_flutterando/src/features/user/user_resource.dart';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import 'database/remote_database.dart';

class AppModule extends Module {

  @override
  List<Bind<Object>> get  binds => [
    Bind.instance<DotEnvService>(DotEnvService.instance),
    Bind.singleton<RemoteDatabase>((i) => PostgresDatabase(i()))
  ] ;



  @override
  List<ModularRoute> get routes => [
        Route.get('/', (Request req) => Response.ok('Inicial')),
        Route.resource(UserResource()),
      ];
}
