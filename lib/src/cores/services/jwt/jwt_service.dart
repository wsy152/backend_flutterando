abstract class JwtService{
  String generateToken(Map claims, String audiance);

  void verifyToken(String token, String audiance);

  Map getPayLoad(String token);
}