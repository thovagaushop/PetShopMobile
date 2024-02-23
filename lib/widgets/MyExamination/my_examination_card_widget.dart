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
      height: 112,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 140,
            height: 95,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: AppColors.secondary1,
              borderRadius: BorderRadius.circular(15),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Date: ${DateTime.parse(widget.examinationBookingModel.date!).year} - ${DateTime.parse(widget.examinationBookingModel.date!).month.toString().padLeft(2, '0')} - ${DateTime.parse(widget.examinationBookingModel.date!).day.toString().padLeft(2, '0')}',
                style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const Divider(
                color: Color.fromRGBO(66, 165, 245, 1), // Color of the line
                thickness: 1.0, // Thickness of the line
              ),
              Text(
                'Time: ${DateTime.parse(widget.examinationBookingModel.date!).hour.toString().padLeft(2, '0')} : ${DateTime.parse(widget.examinationBookingModel.date!).minute.toString().padLeft(2, '0')}',
                style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ]),
          ),
          Container(
            width: 140,
            height: 95,
            decoration: BoxDecoration(
              color: AppColors.secondary1,
              borderRadius: BorderRadius.circular(15),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Description',
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.examinationBookingModel.description!,
                style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.clip),
                maxLines: 3,
              ),
            ]),
            // Expanded(
            //   flex: 0,
            //   child: IconButton(
            //     onPressed: () {
            //       return handleDelete(
            //           userProvider.token, widget.examinationBookingModel.id);
            //     },
            //     icon: const Icon(
            //       Icons.delete,
            //       color: AppColors.mainColorFocus,
            //       size: 30,
            //     ),
            //   ),
            // ),
            // Expanded(
            //     flex: 1,
            //     child: Column(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: [
            //           const Text("Date: "),
            //           Text(widget.examinationBookingModel.date!
            //               .replaceFirst(":00.000+00:00", " UTC")),
            //           const SizedBox(
            //             height: 10,
            //           ),
            //           const Text("Description: "),
            //           Text(widget.examinationBookingModel.description!),
            //         ])),
            // const SizedBox(
            //   width: 10,
            // ),
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
