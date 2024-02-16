import 'package:flutter/material.dart';
import 'package:test_flutter_2/models/user_model.dart';

class UserPorvider with ChangeNotifier {
  late UserModel _user = UserModel();

  String? get token => _user.token;

  void login(UserModel userModel) {
    _user = userModel;
    notifyListeners();
  }

  void logout() {
    _user = UserModel();
    notifyListeners();
  }
}
