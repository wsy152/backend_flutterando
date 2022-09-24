import 'package:backend_flutterando/src/cores/services/bcrypt/bcrypt_service.dart';
import 'package:backend_flutterando/src/cores/services/bcrypt/bcrypt_service_impl.dart';
import 'package:backend_flutterando/src/cores/services/dot_env/dot_env_service.dart';
import 'package:backend_flutterando/src/cores/services/database/postgres/postgres_database.dart';
import 'package:backend_flutterando/src/features/swagger/swagger_handler.dart';
import 'package:backend_flutterando/src/features/user/user_resource.dart';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import 'cores/services/database/remote_database.dart';

class AppModule extends Module {

  @override
  List<Bind<Object>> get  binds => [
    Bind.instance<DotEnvService>(DotEnvService.instance),
    Bind.singleton<RemoteDatabase>((i) => PostgresDatabase(i())),
    Bind.singleton<BCryptService>((i) => BCryptServiceImpl())
  ] ;



  @override
  List<ModularRoute> get routes => [
        Route.get('/', (Request req) => Response.ok('Inicial')),
        Route.get('/documentation/**', swaggerHandler),
        Route.resource(UserResource()),
      ];
}
