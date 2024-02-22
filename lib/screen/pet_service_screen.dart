import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/screen/examination_screen.dart';
import 'package:test_flutter_2/screen/login_screen.dart';
import 'package:test_flutter_2/screen/take_care_screen.dart';

class PetServiceScreen extends StatelessWidget {
  const PetServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.mainColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 80),
              child: Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        final token =
                            Provider.of<UserProvider>(context, listen: false)
                                .token;
                        if (token == null || token.isEmpty) {
                          Future.delayed(const Duration(seconds: 3));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen(
                                      isHistory: true,
                                    )),
                          );

                          return;
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TakeCareScreen()));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(1),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Take care booking",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextButton(
                      onPressed: () {
                        final token =
                            Provider.of<UserProvider>(context, listen: false)
                                .token;
                        if (token == null || token.isEmpty) {
                          Future.delayed(const Duration(seconds: 3));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen(
                                      isHistory: true,
                                    )),
                          );

                          return;
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ExaminationScreen()));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(1),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Examination booking",
                        style: TextStyle(fontSize: 30),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
