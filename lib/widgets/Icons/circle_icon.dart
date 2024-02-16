import 'package:flutter/material.dart';
import 'package:test_flutter_2/common/constant.dart';

class CircleIconCustom extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const CircleIconCustom(
      {super.key,
      required this.icon,
      this.backgroundColor = Colors.white,
      this.iconColor = Colors.black,
      this.size = 36});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3))
          ]),
      child: Center(child: Icon(icon, color: AppColors.primary, size: 14)),
    );
  }
}
