import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_flutter_2/common/constant/common.dart';
import 'package:test_flutter_2/models/product_model.dart';

class ProductService {
  var client = http.Client();
  var baseApiUrl = CommonConst.baseApiUrl;

  Map<String, String> getHeaderAuthorization(String token) {
    return {'Authorization': 'Bearer $token'};
  }

  Future<List<ProductModel>> fetchListProducts() async {
    try {
      var response =
          await client.get(Uri.parse('$baseApiUrl/product?pageSize=100'));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            jsonDecode(response.body.toString());
        print(responseBody);
        List<ProductModel> products = (responseBody['data'] as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();

        return products;
      }

      String message = jsonDecode(response.body.toString())['message'];
      throw Exception(message);
    } catch (e) {
      rethrow;
    }
  }
}
