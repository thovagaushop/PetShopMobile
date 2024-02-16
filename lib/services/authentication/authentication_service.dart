import 'dart:convert';

import 'package:http/http.dart';

class AuthenticationService {
  static const String baseUrl = 'http://192.168.0.107:8080/api';

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
