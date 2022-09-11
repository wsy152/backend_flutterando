import 'dart:async';
import 'dart:developer';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

void main(List<String> arguments) async {

  var pipeline = Pipeline().addMiddleware(log1());

  final servidor = await io.serve(pipeline.addHandler(_handler), '0.0.0.0', 6262);



  log('On Line ${servidor.address.address} ${servidor.port}');  
 
}

Middleware log1(){
  return (handler){
    return (request) async {
        print('${request.url}');
      var response = await handler(request);
      print('${response.statusCode}');
      return response;
    };
  };
}



FutureOr<Response> _handler(Request request){
  log('$request');
  return Response(200,body: 'Corpo');
}
