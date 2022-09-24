import 'package:backend_flutterando/src/app_module.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Handler> startModularShelf() async {
  final handle = Modular(module: AppModule(), middlewares: [logRequests(),jsonResponse()]);

  return handle;
}

Middleware jsonResponse() {
  return (handle) {
    return (request) async {
      var response = await handle(request);

      response = response.change(headers: {
        'content-type': 'application/json',
        ...response.headers,
      });

      return response;
    };
  };
}
