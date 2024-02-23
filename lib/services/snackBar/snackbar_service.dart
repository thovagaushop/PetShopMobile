import 'package:flutter/material.dart';

class SnackBarService {
  static SnackBar showSnackbar(String message, String status) {
    Color color = const Color.fromRGBO(134, 229, 115, 1);
    switch (status) {
      case "success":
        color = const Color.fromRGBO(134, 229, 115, 1);
        break;
      case "danger":
        color = Color.fromARGB(255, 231, 88, 69);
        break;
      case "warning":
        color = Color.fromARGB(255, 229, 212, 115);
        break;
      default:
        break;
    }
    return SnackBar(
      backgroundColor: color,
      content: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      duration: const Duration(milliseconds: 2000),
    );
  }
}
