import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/common/constant/common.dart';
import 'package:test_flutter_2/screen/login_screen.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/widgets/TextField/text_field.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void register(email, firstname, lastname, phoneNumber, password) async {
    try {
      setState(() {
        _isLoading = true;
      });
      var client = http.Client();
      var response = await client.post(
          Uri.parse('${CommonConst.baseApiUrl}/auth/register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'email': email,
            'firstname': firstname,
            'lastname': lastname,
            'phoneNumber': phoneNumber,
            'password': password,
          }));
      if (!context.mounted) return;
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            jsonDecode(response.body.toString());

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBarService.showSnackbar(responseBody['message'], "success"));
        Navigator.pop(context);
      }
      String message = jsonDecode(response.body.toString())['message'];
      throw Exception(message);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary),
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
                            hintText: "First Name",
                            controller: firstNameController,
                            obscureText: false),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldCustom(
                            hintText: "Last Name",
                            controller: lastNameController,
                            obscureText: false),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldCustom(
                          hintText: "Phone Number",
                          controller: phoneNumberController,
                          obscureText: false,
                          digitText: true,
                        ),
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

                        GestureDetector(
                          onTap: () {
                            return register(
                                usernameController.text.toString().trim(),
                                firstNameController.text.toString().trim(),
                                lastNameController.text.toString().trim(),
                                phoneNumberController.text.toString().trim(),
                                passwordController.text.toString().trim());
                            // login(
                            //     provider,
                            //     usernameController.text.toString().trim(),
                            //     passwordController.text.toString().trim());
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
                              "Confirm",
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
                            const Text("Have already account ?",
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
                                            const LoginScreen()));
                              },
                              child: const Text("Sign in",
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
