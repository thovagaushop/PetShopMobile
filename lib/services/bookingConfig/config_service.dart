import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_flutter_2/common/constant/common.dart';
import 'package:test_flutter_2/models/config_model.dart';

class ConfigService {
  var client = http.Client();
  var baseApiUrl = CommonConst.baseApiUrl;

  Map<String, String> getHeaderAuthorization(String token) {
    return {'Authorization': 'Bearer $token'};
  }

  Future<ConfigModel> getConfig() async {
    try {
      var response = await client.get(
        Uri.parse('$baseApiUrl/config'),
      );
      if (response.statusCode == 200) {
        return ConfigModel.fromJson(jsonDecode(response.body.toString()));
      }

      String message = jsonDecode(response.body.toString())['message'];
      throw Exception(message);
    } catch (e) {
      rethrow;
    }
  }
}
