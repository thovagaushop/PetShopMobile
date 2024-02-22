import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_flutter_2/common/constant/common.dart';
import 'package:test_flutter_2/models/profile_model.dart';
import 'package:test_flutter_2/models/user_model.dart';

class ProfileService {
  var client = http.Client();
  var baseApiUrl = CommonConst.baseApiUrl;

  Map<String, String> getHeaderAuthorization(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<ProfileModel> fetchModel(String token) async {
    try {
      var response = await client.get(Uri.parse('$baseApiUrl/users/profile'),
          headers: getHeaderAuthorization(token));
      if (response.statusCode == 200) {
        dynamic responseBody = jsonDecode(response.body.toString());

        ProfileModel profileModel = ProfileModel.fromJson(responseBody);

        return profileModel;
      }

      String message = jsonDecode(response.body.toString())['message'];
      throw Exception(message);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateProfile(ProfileModel profile, String token) async {
    try {
      var response = await client.put(Uri.parse('$baseApiUrl/users/profile'),
          body: jsonEncode({
            "email": profile.email!,
            "firstname": profile.firstname!,
            "lastname": profile.lastname!,
            "phoneNumber": profile.phoneNumber!,
            "address": profile.address!
          }),
          headers: getHeaderAuthorization(token));

      if (response.statusCode == 200) {
        return "Update Successfully";
      }
      String message = jsonDecode(response.body.toString())['message'];
      throw Exception(message);
    } catch (e) {
      rethrow;
    }
  }
}
