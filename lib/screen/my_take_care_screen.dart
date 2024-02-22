import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/my_take_care_model.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/services/takecare/take_care_service.dart';
import 'package:test_flutter_2/widgets/Icons/circle_icon.dart';
import 'package:test_flutter_2/widgets/MyTakeCare/my_take_care_body_widget.dart';

class MyTakeCareScreen extends StatefulWidget {
  const MyTakeCareScreen({super.key});

  @override
  State<MyTakeCareScreen> createState() => _MyTakeCareScreenState();
}

class _MyTakeCareScreenState extends State<MyTakeCareScreen> {
  Future<List<MyTakeCareModel>>? futureMyTakeCareModels;

  void updateItems() {
    setState(() {
      futureMyTakeCareModels = fetchMyTakeCareModels();
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
      futureMyTakeCareModels = fetchMyTakeCareModels();
    });
  }

  Future<List<MyTakeCareModel>> fetchMyTakeCareModels() async {
    String token = Provider.of<UserProvider>(context, listen: false).token!;
    try {
      List<MyTakeCareModel> myTakeCareModels =
          await TakeCareService().fetchTakeCares(token);

      if (!context.mounted) return [];

      return myTakeCareModels;
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
            body: FutureBuilder<List<MyTakeCareModel>>(
              future: futureMyTakeCareModels,
              builder: (context, data) {
                if (data.hasData) {
                  List<MyTakeCareModel> takeCares = data.data!;
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
                          child: MyTakeCareBodyWidget(
                              takeCareModel: takeCares,
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
