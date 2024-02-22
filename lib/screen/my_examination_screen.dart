import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/examination_booking_model.dart';
import 'package:test_flutter_2/services/examination/examination_service.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/widgets/Icons/circle_icon.dart';
import 'package:test_flutter_2/widgets/MyExamination/my_examination_body_widget.dart';

class MyExaminationScreen extends StatefulWidget {
  const MyExaminationScreen({super.key});

  @override
  State<MyExaminationScreen> createState() => _MyExaminationScreenState();
}

class _MyExaminationScreenState extends State<MyExaminationScreen> {
  Future<List<ExaminationBookingModel>>? futureExaminationBookingModels;

  void updateItems() {
    setState(() {
      futureExaminationBookingModels = fetchExaminationBookingModels();
    });
  }

  void fetchData() {
    final token = Provider.of<UserProvider>(context, listen: false).token;
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarService.showSnackbar("You need to login first !!", "danger"),
      );
      return;
    }
    setState(() {
      futureExaminationBookingModels = fetchExaminationBookingModels();
    });
  }

  Future<List<ExaminationBookingModel>> fetchExaminationBookingModels() async {
    String token = Provider.of<UserProvider>(context, listen: false).token!;
    try {
      List<ExaminationBookingModel> examinationBookingModels =
          await ExaminationService().fetchExaminations(token);

      if (!context.mounted) return [];

      return examinationBookingModels;
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
      return [];
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
            body: FutureBuilder<List<ExaminationBookingModel>>(
              future: futureExaminationBookingModels,
              builder: (context, data) {
                if (data.hasData) {
                  List<ExaminationBookingModel> examinations = data.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Row(
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
                            const Text(
                              "My examinations",
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(width: 50, child: null),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: MyExaminationBodyWidget(
                              examinationModel: examinations,
                              onUpdate: () {
                                updateItems();
                              }),
                        ),
                      ],
                    ),
                  );
                } else if (data.hasError) {
                  return Text('Error: ${data.error}');
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )));
  }
}
