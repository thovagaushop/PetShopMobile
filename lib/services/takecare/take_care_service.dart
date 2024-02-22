import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_flutter_2/common/constant/common.dart';
import 'package:test_flutter_2/models/my_take_care_model.dart';

class TakeCareService {
  var client = http.Client();
  var baseApiUrl = CommonConst.baseApiUrl;

  Map<String, String> getHeaderAuthorization(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
  }

  Future<List<MyTakeCareModel>> fetchTakeCares(String token) async {
    try {
      var response = await client.get(
          Uri.parse('$baseApiUrl/take-care-bookings'),
          headers: getHeaderAuthorization(token));
      if (response.statusCode == 200) {
        dynamic responseBody = jsonDecode(response.body.toString());

        List<MyTakeCareModel> orders = (responseBody as List)
            .map((json) => MyTakeCareModel.fromJson(json))
            .toList();

        return orders;
      }

      String message = jsonDecode(response.body.toString())['message'];
      throw Exception(message);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteTakeCares(String token, int bookingId) async {
    try {
      dynamic response = await client.delete(
          Uri.parse('$baseApiUrl/take-care-bookings/$bookingId'),
          headers: getHeaderAuthorization(token));
      if (response.statusCode == 200) {
        dynamic responseBody = jsonDecode(response.body.toString());
        String message = responseBody["message"];
        return message;
      }

      String message = jsonDecode(response.body.toString())['message'];
      throw Exception(message);
    } catch (e) {
      rethrow;
    }
  }
}
