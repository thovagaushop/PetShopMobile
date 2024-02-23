import 'package:flutter/material.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/widgets/Icons/circle_icon.dart';

class ServiceHeaderWidget extends StatelessWidget {
  final String title;
  const ServiceHeaderWidget({super.key, this.title = "Service"});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const CircleIconCustom(
              icon: Icons.arrow_back_ios_new,
              iconSize: 18,
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
              color: AppColors.primary,
              fontSize: 32,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic),
        ),
        const SizedBox(width: 50, child: null),
      ],
    );
  }
}
