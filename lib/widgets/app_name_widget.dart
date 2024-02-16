import 'package:flutter/material.dart';
import 'package:test_flutter_2/common/constant.dart';
import 'package:test_flutter_2/widgets/TextField/text_buidler.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextBuilder(
            text: 'SUPER ',
            color: AppColors.kBlue,
            fontSize: 30,
            fontWeight: FontWeight.w700),
        TextBuilder(text: 'STORE', color: AppColors.kGreen, fontSize: 30),
      ],
    );
  }
}
