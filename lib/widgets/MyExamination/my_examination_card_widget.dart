import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/examination_booking_model.dart';
import 'package:test_flutter_2/services/examination/examination_service.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';

class MyExaminationCardWidget extends StatefulWidget {
  final ExaminationBookingModel examinationBookingModel;
  final VoidCallback onUpdate;
  const MyExaminationCardWidget(
      {super.key,
      required this.examinationBookingModel,
      required this.onUpdate});

  @override
  State<MyExaminationCardWidget> createState() =>
      _MyExaminationCardWidgetState();
}

class _MyExaminationCardWidgetState extends State<MyExaminationCardWidget> {
  bool _isLoading = false;
  void handleDelete(token, bookingId) async {
    try {
      setState(() {
        _isLoading = true;
      });

      String message =
          await ExaminationService().deleteExamations(token, bookingId);
      if (!context.mounted) return;
      widget.onUpdate();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(message, "success"));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Date: "),
                    Text(widget.examinationBookingModel.date!
                        .replaceFirst(":00.000+00:00", " UTC")),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Description: "),
                    Text(widget.examinationBookingModel.description!),
                  ])),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 0,
            child: IconButton(
              onPressed: () {
                return handleDelete(
                    userProvider.token, widget.examinationBookingModel.id);
              },
              icon: const Icon(
                Icons.delete,
                color: AppColors.mainColorFocus,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}