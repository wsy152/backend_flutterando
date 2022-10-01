
import 'package:backend_flutterando/src/cores/services/jwt/jwt_service.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../../dot_env/dot_env_service.dart';

class JwtServiceImpl implements JwtService{
   final DotEnvService _dotEnvService;

  JwtServiceImpl(this._dotEnvService);

  @override
  String generateToken(Map claims, String audiance) {
    final jwt = JWT(claims, audience: Audience.one(audiance));

    final token = jwt.sign(SecretKey(_dotEnvService['JWT_KEY']!));

    return token;
  }

  @override
  Map getPayLoad(String token) {
    final jwt = JWT.verify(
        token, 
        SecretKey(_dotEnvService['JWT_KEY']!),        
        checkExpiresIn: false,
        checkHeaderType: false,
        checkNotBefore: false);
        return jwt.payload;
  }

  @override
  void verifyToken(String token, String audiance) {
    JWT.verify(token, SecretKey(_dotEnvService['JWT_KEY']!),
        audience: Audience.one(audiance));
  }
  
}