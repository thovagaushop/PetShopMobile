import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';

class TextFieldCustom extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final bool digitText;

  const TextFieldCustom(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.obscureText,
      this.digitText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: digitText
          ? const TextInputType.numberWithOptions(decimal: true)
          : null,
      inputFormatters: digitText
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        border: const OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: AppColors.mainColor, width: 2.0)),
        enabledBorder: const OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: AppColors.mainColor, width: 2.0)),
        focusedBorder: const OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide:
                BorderSide(color: AppColors.mainColorFocus, width: 2.0)),
        // prefixIcon: const Icon(Icons.person),
        // suffixIcon: const Icon(Icons.check_circle),
      ),
    );
  }
}
