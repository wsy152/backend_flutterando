abstract class BCryptService{
  String generatehash(String text);

  bool checkHas(String text, String hash);
}