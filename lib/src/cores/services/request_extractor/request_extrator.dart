// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:shelf/shelf.dart';

class RequestExtrator {
  String getAuthorizationBearer(Request request) {
    var authorization = request.headers['authorization'] ?? '';

    authorization = authorization.split(' ').last;
    return authorization;
  }

  LoginCredencial getAuthorizationBasic(Request request) {
    var authorization = request.headers['authorization'] ?? '';

    authorization = authorization.split(' ').last;

    authorization = String.fromCharCodes(base64Decode(authorization));

    final credential = authorization.split(':');
    return LoginCredencial(email: credential.first, password: credential.last);
  }
}

class LoginCredencial {
  final String email;
  final String password;
  LoginCredencial({
    required this.email,
    required this.password,
  });
}
