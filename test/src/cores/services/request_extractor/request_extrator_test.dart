import 'dart:convert';

import 'package:backend_flutterando/src/cores/services/request_extractor/request_extrator.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

void main() {
  final extrator = RequestExtrator();
  test('getAuthorizationBearer', () async {
    final request = Request('GET', Uri.parse('http://localhost/'),
        headers: {'authorization': 'bearer djfalkjkdfjfçlkjklfdasj'});
    final token = extrator.getAuthorizationBearer(request);
    expect(token, 'djfalkjkdfjfçlkjklfdasj');
  });

  test('getAuthorizationBasic', () async {
    var credentialAuth = 'edy@gmail.com:123';
    credentialAuth = base64Encode(credentialAuth.codeUnits);

    final request = Request('GET', Uri.parse('http://localhost/'),
        headers: {'authorization': 'basic $credentialAuth'});
    final credential = extrator.getAuthorizationBasic(request);
    expect(credential.email, 'edy@gmail.com');
    expect(credential.password, '123');
  });
}