import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

class UserResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/user', _getAllUser),
        Route.get('/user/:id', _getUserbyIdr),
        Route.post('/user', _createUser),
        Route.put('/user/:id', _updateUser),
        Route.delete('/user/:id', _deleteUser),
      ];

  FutureOr<Response> _getAllUser() {
    return Response.ok('ok');
  }

  FutureOr<Response> _getUserbyIdr(ModularArguments args) {
    return Response.ok(args.params['id']);
  }

  FutureOr<Response> _createUser(ModularArguments args) {
    return Response.ok(args.data);
  }

  FutureOr<Response> _updateUser(ModularArguments args) {
    return Response.ok(args.data);
  }
    FutureOr<Response> _deleteUser(ModularArguments args) {
    return Response.ok(args.params['id']);
  }
}
