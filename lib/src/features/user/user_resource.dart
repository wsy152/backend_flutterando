import 'dart:async';
import 'dart:convert';
import 'package:backend_flutterando/src/cores/services/bcrypt/bcrypt_service.dart';
import 'package:backend_flutterando/src/cores/services/database/remote_database.dart';
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

  FutureOr<Response> _createUser(ModularArguments args,Injector injector) async{

    final bcrypt = injector.get<BCryptService>();


      final userParams = (args.data as Map).cast<String, dynamic>();

       userParams['password'] = bcrypt.generatehash(userParams['password']);
       
      userParams.remove('id');

      final database = injector.get<RemoteDatabase>();
      final result = await database.query('INSERT INTO "User" (name, email) VALUES(@name, @email) RETURNING id,name,email,role;',variables: userParams);
      final userMap = result.map((e) => e['User']).first;
    return Response.ok(jsonEncode(userMap));
  }

  FutureOr<Response> _updateUser(ModularArguments args,Injector injector) async{
          final userParams = (args.data as Map).cast<String, dynamic>();
      userParams.remove('id');

      final database = injector.get<RemoteDatabase>();
      final result = await database.query('UPDATE INTO "User" (name, email) VALUES(@name, @email) RETURNING id,name,email,role;',variables: userParams);
      final userMap = result.map((e) => e['User']).first;
    return Response.ok(jsonEncode(userMap));
  }
    FutureOr<Response> _deleteUser(ModularArguments args,Injector injector) async{
      final id = args.params ['id'];
      final database = injector.get<RemoteDatabase>();
      await database.query('DELETE FROM "User" WHERE id = @id;',variables: {
        'id':id

      });

    return Response.ok(jsonEncode({'message': 'deleted $id'}));
  }
}
