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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Date & Time",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: AppColors.secondary1,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.5), // Màu của bóng đổ và độ trong suốt
                        spreadRadius: 2, // Độ lan rộng của bóng đổ
                        blurRadius: 5, // Độ mờ của bóng đổ
                        offset: const Offset(0,
                            2), // Độ dịch chuyển của bóng đổ theo trục X và Y
                      ),
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'From: ${widget.takeCareModel.startDate!.replaceFirst(":00.000+00:00", " UTC")}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'To: ${widget.takeCareModel.endDate!.replaceFirst(":00.000+00:00", " UTC")}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
              // Pet type
              const Text(
                "Pet Type",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: AppColors.secondary1,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(
                              0.5), // Màu của bóng đổ và độ trong suốt
                          spreadRadius: 2, // Độ lan rộng của bóng đổ
                          blurRadius: 5, // Độ mờ của bóng đổ
                          offset: const Offset(0,
                              2), // Độ dịch chuyển của bóng đổ theo trục X và Y
                        ),
                      ]),
                  child: Center(
                    child: Text(
                      widget.takeCareModel.petType!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )),
              // Note
              const Text(
                "Pet Type",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: AppColors.secondary1,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(
                              0.5), // Màu của bóng đổ và độ trong suốt
                          spreadRadius: 2, // Độ lan rộng của bóng đổ
                          blurRadius: 5, // Độ mờ của bóng đổ
                          offset: const Offset(0,
                              2), // Độ dịch chuyển của bóng đổ theo trục X và Y
                        ),
                      ]),
                  child: Center(
                    child: Text(
                      widget.takeCareModel.note!,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.clip),
                      maxLines: 2,
                    ),
                  )),

              // Price
              const Text(
                "Pet Type",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: AppColors.secondary1,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(
                              0.5), // Màu của bóng đổ và độ trong suốt
                          spreadRadius: 2, // Độ lan rộng của bóng đổ
                          blurRadius: 5, // Độ mờ của bóng đổ
                          offset: const Offset(0,
                              2), // Độ dịch chuyển của bóng đổ theo trục X và Y
                        ),
                      ]),
                  child: Center(
                    child: Text(
                      widget.takeCareModel.price!.toString(),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.clip),
                      maxLines: 2,
                    ),
                  )),
            ],
          ),
        ),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Expanded(
        //         flex: 1,
        //         child: Column(
        //             mainAxisAlignment: MainAxisAlignment.spaceAround,
        //             children: [
        //               const Text("From: "),
        //               Text(widget.takeCareModel.startDate!
        //                   .replaceFirst(":00.000+00:00", " UTC")),
        //               const SizedBox(
        //                 height: 10,
        //               ),
        //               const Text("To: "),
        //               Text(widget.takeCareModel.endDate!
        //                   .replaceFirst(":00.000+00:00", " UTC")),
        //               const SizedBox(
        //                 height: 10,
        //               ),
        //               const Text("Pet type: "),
        //               Text(widget.takeCareModel.petType!),
        //               const SizedBox(
        //                 height: 10,
        //               ),
        //               const Text("Note: "),
        //               Text(widget.takeCareModel.note!),
        //               const Text("Price: "),
        //               Text(widget.takeCareModel.price!.toString()),
        //               const SizedBox(
        //                 height: 10,
        //               ),
        //             ])),
        //     const SizedBox(
        //       width: 10,
        //     ),
        //     Expanded(
        //       flex: 0,
        //       child: IconButton(
        //         onPressed: () {
        //           return handleDelete(
        //               userProvider.token, widget.takeCareModel.id);
        //         },
        //         icon: const Icon(
        //           Icons.delete,
        //           color: AppColors.mainColorFocus,
        //           size: 30,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
