import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/user_model.dart';
import 'package:test_flutter_2/screen/home_screen.dart';
import 'package:test_flutter_2/services/authentication/authentication_service.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/widgets/TextField/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void login(provider, email, password) async {
    try {
      dynamic response = await AuthenticationService.login(email, password);
      if (!context.mounted) return;
      provider.login(UserModel.fromJson(response));
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBarService.showSnackbar("Login Success", "success"));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserPorvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(children: [
            const SizedBox(
              height: 70,
            ),
            const Text(
              "Sign In",
              style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: AppColors.mainColor),
            ),
            const SizedBox(
              height: 50,
            ),
            TextFieldCustom(
                hintText: "Your Email",
                controller: usernameController,
                obscureText: false),
            const SizedBox(
              height: 30,
            ),
            TextFieldCustom(
                hintText: "Password",
                controller: passwordController,
                obscureText: true),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                login(provider, usernameController.text.toString().trim(),
                    passwordController.text.toString().trim());
              },
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: const Center(
                    child: Text(
                  "Sign In",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
              ),
            )
            // TextButton(onPressed: , child: child)
          ]),
        ),
      )),
    );
  }
}
