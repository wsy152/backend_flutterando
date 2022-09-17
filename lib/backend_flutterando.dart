import 'package:backend_flutterando/src/app_module.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Handler> startModularShelf()async{

  final handle = Modular(module: AppModule(),middlewares: [
    logRequests()
  ]);

  return handle;


}