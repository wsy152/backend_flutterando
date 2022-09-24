import 'package:backend_flutterando/src/cores/services/bcrypt/bcrypt_service.dart';
import 'package:bcrypt/bcrypt.dart';

class BCryptServiceImpl implements BCryptService {
  @override
  bool checkHas(String text, String hash) {
    return BCrypt.checkpw(text, hash);
  }

  @override
  String generatehash(String text) {
    final String hashed = BCrypt.hashpw(text, BCrypt.gensalt());
    return hashed;
  }
}
