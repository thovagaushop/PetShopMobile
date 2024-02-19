import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/user_model.dart';
import 'package:test_flutter_2/screen/index.dart';
import 'package:test_flutter_2/screen/register_screen.dart';
import 'package:test_flutter_2/services/authentication/authentication_service.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/widgets/TextField/text_field.dart';

class LoginScreen extends StatefulWidget {
  final isHistory;
  const LoginScreen({super.key, this.isHistory = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void login(provider, email, password) async {
    setState(() {
      _isLoading = true;
    });
    try {
      dynamic response = await AuthenticationService.login(email, password);
      if (!context.mounted) return;
      provider.login(UserModel.fromJson(response));
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBarService.showSnackbar("Login Success", "success"));

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const IndexScreen()));
      return;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
          child: _isLoading
              ? const Center(
                  child:
                      CircularProgressIndicator(), // or any other loading indicator
                )
              : SingleChildScrollView(
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
                              color: AppColors.primary),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.mainColorFocus,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Bootstrap.google, color: Colors.white),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "With Google",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                                flex: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.mainColorFocus,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Center(
                                      child: Icon(BoxIcons.bxl_facebook,
                                          color: AppColors.mainColorFocus)),
                                )),
                            const SizedBox(width: 20),
                            Expanded(
                                flex: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.mainColorFocus,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Center(
                                      child: Icon(BoxIcons.bxl_twitter,
                                          color: AppColors.mainColorFocus)),
                                )),
                            const SizedBox(width: 20),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Center(
                          child: Text(
                            "Or with Email",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
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
                            login(
                                provider,
                                usernameController.text.toString().trim(),
                                passwordController.text.toString().trim());
                          },
                          child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
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
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("New User ?",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black)),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()));
                              },
                              child: const Text("Sign up",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.mainColorFocus,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        )
                        // TextButton(onPressed: , child: child)
                      ]),
                    ),
                  ),
                )),
    );
  }
}
