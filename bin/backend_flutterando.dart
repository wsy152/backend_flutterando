import 'dart:async';
import 'dart:developer';

import 'package:backend_flutterando/backend_flutterando.dart';

import 'package:shelf/shelf_io.dart' as io;

void main(List<String> arguments) async {

  final handler = await startModularShelf();
  final servidor = await io.serve(handler, '0.0.0.0', 6262);

  log('On Line ${servidor.address.address} ${servidor.port}');  
 
}


