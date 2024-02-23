import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/config_model.dart';
import 'package:test_flutter_2/services/bookingConfig/config_service.dart';
import 'package:test_flutter_2/services/examination/examination_service.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/widgets/DateTimePicker/custom_date_picker_widget.dart';
import 'package:test_flutter_2/widgets/Header/main_header.dart';
import 'package:test_flutter_2/screen/index.dart';
import 'package:test_flutter_2/widgets/Header/service_header.dart';
import 'package:test_flutter_2/widgets/Header/title_header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExaminationScreen extends StatefulWidget {
  const ExaminationScreen({super.key});

  @override
  State<ExaminationScreen> createState() => _ExaminationScreenState();
}

class _ExaminationScreenState extends State<ExaminationScreen> {
  Future<ConfigModel?>? futureConfigModel;
  final descriptionController = TextEditingController();
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  String description = "";

  void fetchData() {
    setState(() {
      futureConfigModel = fetchConfig();
    });
  }

  Future<ConfigModel?> fetchConfig() async {
    try {
      ConfigModel configModel = await ConfigService().getConfig();

      if (!context.mounted) return null;

      return configModel;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
      return null;
    }
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(2025),
            initialDate: DateTime.now())
        .then((value) => {
              setState(() {
                date = value!;
              })
            });
  }

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) => {
              setState(() {
                time = value!;
              })
            });
  }

  Future<void> handleSubmit(String description) async {
    String dateString =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    String timeString =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    if (dateString.isEmpty || timeString.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBarService.showSnackbar("Please fill all fields", "danger"));
      return;
    }
    try {
      final token = Provider.of<UserProvider>(context, listen: false).token!;
      String message = await ExaminationService().createBooking(
          token, '${dateString}T$timeString:00.000+07:00', description);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(message, "success"));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const IndexScreen(
            currentIndex: 2,
          ),
        ),
      );
      return;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
      return;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.mainColor,
            body: FutureBuilder<ConfigModel?>(
                future: futureConfigModel,
                builder: (context, data) {
                  if (data.hasData) {
                    ConfigModel? config = data.data;

                    if (config != null) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              const ServiceHeaderWidget(),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const TitleHeaderWidget(
                                      title: "BOOKING-EXAMINATION",
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Date Picker
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Date",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Container(
                                              width: 140,
                                              height: 190,
                                              decoration: const BoxDecoration(
                                                  color: AppColors.secondary1,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          date.year.toString(),
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .primary,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          date.month
                                                              .toString()
                                                              .padLeft(2, '0'),
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .primary,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                          child: Center(
                                                              child: Text("-")),
                                                        ),
                                                        Text(
                                                          date.day
                                                              .toString()
                                                              .padLeft(2, '0'),
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .primary,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: InkWell(
                                                      onTap: _showDatePicker,
                                                      child: Image.asset(
                                                        "assets/images/timepicker.png",
                                                        width: 130,
                                                        height: 130,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),

                                        // Time picker
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Time",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Container(
                                              width: 140,
                                              height: 190,
                                              decoration: const BoxDecoration(
                                                  color: AppColors.secondary1,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          time.hour
                                                              .toString()
                                                              .padLeft(2, '0'),
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .primary,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        const Text(
                                                          ":",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .primary,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          time.minute
                                                              .toString()
                                                              .padLeft(2, '0')
                                                              .toString()
                                                              .padLeft(2, '0'),
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .primary,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: InkWell(
                                                      onTap: _showTimePicker,
                                                      child: Image.asset(
                                                        "assets/images/datepicker.png",
                                                        width: 130,
                                                        height: 130,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    // Available slot
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 5),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          color: AppColors.secondary1),
                                      child: const Text(
                                        "Available slots",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primary),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.secondary1,
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${((config.maxPlaceExamination ?? 0) - (config.currentExaminationBooking ?? 0)).toString()}",
                                              style: const TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ]),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    // Decoration
                                    Expanded(
                                      flex: 0,
                                      child: Card(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: descriptionController,
                                              maxLines: 5, //or null
                                              decoration: const InputDecoration
                                                  .collapsed(
                                                  hintText:
                                                      "Enter your text here"),
                                            ),
                                          )),
                                    ),

                                    const SizedBox(
                                      height: 30,
                                    ),
                                    // Button Booking
                                    GestureDetector(
                                      onTap: () => {
                                        handleSubmit(descriptionController.text
                                            .toString()
                                            .trim())
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 70),
                                        decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: const Text(
                                          "Booking",
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
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text("Config null"),
                      );
                    }
                  } else if (data.hasError) {
                    return Text('Error: ${data.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })));
  }
}
