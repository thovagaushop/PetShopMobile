import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_flutter_2/common/constant/common.dart';

class ExaminationService {
  var client = http.Client();
  var baseApiUrl = CommonConst.baseApiUrl;

  Map<String, String> getHeaderAuthorization(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
  }

  Future<String> createBooking(
      String token, String date, String description) async {
    print(token);
    print(date);
    print(description);
    try {
      var response = await http.post(
        Uri.parse('$baseApiUrl/examination-bookings'),
        body: jsonEncode({"date": date, "description": description}),
        headers: getHeaderAuthorization(token),
      );
      if (response.statusCode == 200) {
        return "Sucess";
      }

      String message = jsonDecode(response.body.toString())['message'];
      throw Exception(message);
    } catch (e) {
      rethrow;
    }
  }
}