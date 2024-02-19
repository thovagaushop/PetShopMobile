import 'dart:convert';

import 'package:http/http.dart';
import 'package:test_flutter_2/common/constant/common.dart';

class AuthenticationService {
  static const String baseUrl = CommonConst.baseApiUrl;

  static dynamic login(email, password) async {
    try {
      Response response = await post(Uri.parse('$baseUrl/auth/login'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body.toString());
      } else {
        String message = jsonDecode(response.body.toString())['message'];
        throw Exception(message);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
