import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/widgets/Header/main_header.dart';

class ExaminationScreen extends StatefulWidget {
  const ExaminationScreen({super.key});

  @override
  State<ExaminationScreen> createState() => _ExaminationScreenState();
}

class _ExaminationScreenState extends State<ExaminationScreen> {
  void _showDatePicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(2025),
            initialDate: DateTime.now())
        .then((value) => {});
  }

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) => {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const MainHeaderWidget(hasLeftIcon: false),
            const Center(
              child: Text(
                "Form booking an examination",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppColors.mainColorFocus,
              ),
              child: const Text(
                "Availble slot: 10",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: _showDatePicker,
              child: Text(
                'Choose Date',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              color: AppColors.primary,
            ),
            Expanded(
              flex: 0,
              child: MaterialButton(
                onPressed: _showTimePicker,
                child: Text(
                  'Choose Time',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                color: AppColors.primary,
              ),
            ),
            const Expanded(
              flex: 0,
              child: Card(
                  color: Colors.grey,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: 8, //or null
                      decoration: InputDecoration.collapsed(
                          hintText: "Enter your text here"),
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  "Pay now",
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
