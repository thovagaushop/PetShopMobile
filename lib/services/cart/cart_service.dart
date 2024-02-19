import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_flutter_2/common/constant/common.dart';
import 'package:test_flutter_2/models/cart_model.dart';

class CartService {
  var client = http.Client();
  var baseApiUrl = CommonConst.baseApiUrl;

  Map<String, String> getHeaderAuthorization(String token) {
    return {'Authorization': 'Bearer $token'};
  }

  Future<int> getCartId(String token) async {
    try {
      var response = await client.get(Uri.parse('$baseApiUrl/cart'),
          headers: getHeaderAuthorization(token));
      if (response.statusCode == 200) {
        return jsonDecode(response.body.toString())["cartId"];
      }

      String message = jsonDecode(response.body.toString())['message'];
      throw Exception(message);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CartModel>> fetchCartProduct(String token) async {
    try {
      var response = await client.get(Uri.parse('$baseApiUrl/cart'),
          headers: getHeaderAuthorization(token));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            jsonDecode(response.body.toString());
        List<CartModel> products = (responseBody['products'] as List)
            .map((json) => CartModel.fromJson(json))
            .toList();

        return products;
      }

      String message = jsonDecode(response.body.toString())['message'];
      throw Exception(message);
    } catch (e) {
      rethrow;
    }
  }

  Future<CartModel> addProductToCart(
      int productId, int quantity, String token) async {
    try {
      int cartId = await getCartId(token);
      var response = await client.post(
          Uri.parse('$baseApiUrl/cart/$cartId/$productId/quantity/$quantity'),
          headers: getHeaderAuthorization(token));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            jsonDecode(response.body.toString());
        List<CartModel> products = (responseBody['products'] as List)
            .map((json) => CartModel.fromJson(json))
            .toList();
        CartModel cartModel =
            products.firstWhere((element) => element.productId == productId);
        return cartModel;
      }

      String message = jsonDecode(response.body.toString())['message'];
      throw Exception(message);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteProductFromCart(int productId, String token) async {
    try {
      int cartId = await getCartId(token);
      var response = await client.delete(
          Uri.parse('$baseApiUrl/cart/$cartId/$productId'),
          headers: getHeaderAuthorization(token));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            jsonDecode(response.body.toString());

        return responseBody["message"];
      }

      String message = jsonDecode(response.body.toString())['message'];
      throw Exception(message);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateQuantity(
      int productId, String token, int quantity) async {
    try {
      int cartId = await getCartId(token);
      var response = await client.put(
          Uri.parse('$baseApiUrl/cart/$cartId/$productId/quantity/$quantity'),
          headers: getHeaderAuthorization(token));

      if (response.statusCode == 200) {
        return "Updated quantity successfully";
      }

      String message = jsonDecode(response.body.toString())['message'];
      throw Exception(message);
    } catch (e) {
      rethrow;
    }
  }
}
