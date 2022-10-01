import 'package:backend_flutterando/src/cores/services/dot_env/dot_env_service.dart';
import 'package:backend_flutterando/src/cores/services/jwt/dart_json_web_token/jwt_service_impl.dart';
import 'package:test/test.dart';

void main() {
  test('JWT create ', () async {
   final dotEnvService = DotEnvService(mocks: {
    'JWT_KEY': 'kdjaflçkjdsflç sjfdslçkfjdlskjf'

   });

   final jwt = JwtServiceImpl(dotEnvService);

   final expriresDate = DateTime.now().add(Duration(seconds: 30));

   final expiresIn = Duration(milliseconds: expriresDate.millisecondsSinceEpoch).inSeconds;


  final token=  jwt.generateToken({'id': 1, 'role': 'user', 'exp':expiresIn}, 'accessToken');

   print(token);
  });


    test('JWT verify ', () async {
   final dotEnvService = DotEnvService(mocks: {
    'JWT_KEY': 'kdjaflçkjdsflç sjfdslçkfjdlskjf'

   });

   final jwt = JwtServiceImpl(dotEnvService);




    jwt.verifyToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwicm9sZSI6InVzZXIiLCJleHAiOjE2NjQ2Mzg5MTMsImlhdCI6MTY2NDYzODg4NywiYXVkIjoiYWNjZXNzVG9rZW4ifQ.hm9bIiNXhoOXy3ai5-8xZdljbT5wGsWQlvJxHF23wpY','accessToken');


  });



    test('JWT payload ', () async {
   final dotEnvService = DotEnvService(mocks: {
    'JWT_KEY': 'kdjaflçkjdsflç sjfdslçkfjdlskjf'

   });

   final jwt = JwtServiceImpl(dotEnvService);




    final payload = jwt.getPayLoad('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwicm9sZSI6InVzZXIiLCJleHAiOjE2NjQ2Mzg5MTMsImlhdCI6MTY2NDYzODg4NywiYXVkIjoiYWNjZXNzVG9rZW4ifQ.hm9bIiNXhoOXy3ai5-8xZdljbT5wGsWQlvJxHF23wpY');
   
    print(payload);

  });
}