import 'package:flutter/material.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/screen/examination_screen.dart';
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TakeCareScreen()));
                      },
                      child: Text(
                        "Take care booking",
                        style: TextStyle(fontSize: 30),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ExaminationScreen()));
                      },
                      child: Text(
                        "Examination booking",
                        style: TextStyle(fontSize: 30),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(1),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
