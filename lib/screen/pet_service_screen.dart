import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/screen/examination_screen.dart';
import 'package:test_flutter_2/screen/login_screen.dart';
import 'package:test_flutter_2/screen/take_care_screen.dart';
import 'package:test_flutter_2/widgets/Header/service_header.dart';
import 'package:test_flutter_2/widgets/Icons/circle_icon.dart';

class PetServiceScreen extends StatelessWidget {
  const PetServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.mainColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Column(
                  children: [
                    const ServiceHeaderWidget(),
                    // Service
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              final token = Provider.of<UserProvider>(context,
                                      listen: false)
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
                                          const TakeCareScreen()));
                            },
                            child: Container(
                              width: 278,
                              height: 234,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        color: AppColors.takeCareImage),
                                    child: Image.asset(
                                      "assets/images/takecare.png",
                                      // width: 200,
                                      // height: 200,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  // const Expanded(child: SizedBox(height: 20)),
                                  const Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "BOOKING - TAKE CARE",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              final token = Provider.of<UserProvider>(context,
                                      listen: false)
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
                            child: Container(
                              width: 278,
                              height: 234,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        color: AppColors.examinationImage),
                                    child: Image.asset(
                                      "assets/images/examination.png",
                                      // width: 200,
                                      // height: 200,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  // const Expanded(child: SizedBox(height: 20)),
                                  const Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "BOOKING - EXAMINATION",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
