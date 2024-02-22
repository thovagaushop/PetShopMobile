import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/my_take_care_model.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/services/takecare/take_care_service.dart';

class MyTakeCareCardWidget extends StatefulWidget {
  final MyTakeCareModel takeCareModel;
  final VoidCallback onUpdate;
  const MyTakeCareCardWidget(
      {super.key, required this.takeCareModel, required this.onUpdate});

  @override
  State<MyTakeCareCardWidget> createState() => _MyTakeCareCardWidgetState();
}

class _MyTakeCareCardWidgetState extends State<MyTakeCareCardWidget> {
  bool _isLoading = false;
  void handleDelete(token, bookingId) async {
    try {
      setState(() {
        _isLoading = true;
      });

      String message =
          await TakeCareService().deleteTakeCares(token, bookingId);
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
                    const Text("From: "),
                    Text(widget.takeCareModel.startDate!
                        .replaceFirst(":00.000+00:00", " UTC")),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("To: "),
                    Text(widget.takeCareModel.endDate!
                        .replaceFirst(":00.000+00:00", " UTC")),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Pet type: "),
                    Text(widget.takeCareModel.petType!),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Note: "),
                    Text(widget.takeCareModel.note!),
                    const Text("Price: "),
                    Text(widget.takeCareModel.price!.toString()),
                    const SizedBox(
                      height: 10,
                    ),
                  ])),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 0,
            child: IconButton(
              onPressed: () {
                return handleDelete(
                    userProvider.token, widget.takeCareModel.id);
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
