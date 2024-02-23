import 'package:flutter/material.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';

class TitleHeaderWidget extends StatelessWidget {
  final String title;
  const TitleHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey
                .withOpacity(0.5), // Màu của bóng đổ và độ trong suốt
            spreadRadius: 2, // Độ lan rộng của bóng đổ
            blurRadius: 5, // Độ mờ của bóng đổ
            offset: const Offset(
                0, 2), // Độ dịch chuyển của bóng đổ theo trục X và Y
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 22,
              color: AppColors.primary,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
