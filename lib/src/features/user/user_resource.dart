import 'dart:async';
import 'dart:convert';

import 'package:backend_flutterando/src/database/remote_database.dart';
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

  FutureOr<Response> _getAllUser(Injector injector) async{
    final database = injector.get<RemoteDatabase>();
    final result = await database.query('SELECT * from "User"');
    final listUsers = result.map((e) => e['User']).toList();

    return Response.ok(jsonEncode(listUsers));
  }

  FutureOr<Response> _getUserbyIdr(ModularArguments args,Injector injector)async {
    final id = args.params['id'];
    final database = injector.get<RemoteDatabase>();
    final result = await database.query('SELECT * from "User" WHERE id = @id' ,
    variables: {
      'id': id
    }
    );
    final userMap = result.map((e) => e['User']).first;

    return Response.ok(jsonEncode(userMap));
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
