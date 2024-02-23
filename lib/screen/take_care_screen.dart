import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/common/constant/common.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/config_model.dart';
import 'package:test_flutter_2/models/service_select_model.dart';
import 'package:test_flutter_2/screen/index.dart';
import 'package:test_flutter_2/screen/my_take_care_screen.dart';
import 'package:test_flutter_2/screen/pet_service_screen.dart';
import 'package:test_flutter_2/services/bookingConfig/config_service.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/utils/utils.dart';
import 'package:test_flutter_2/widgets/Header/main_header.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter_2/widgets/Header/service_header.dart';
import 'package:test_flutter_2/widgets/Header/title_header_widget.dart';

class TakeCareScreen extends StatefulWidget {
  const TakeCareScreen({super.key});

  @override
  State<TakeCareScreen> createState() => _TakeCareScreenState();
}

const List<String> listPetType = <String>[
  'SENIOR_DOG',
  'CAT',
  'FISH',
  'SMALL_PET',
  'BIRD',
  'REPTILE',
  'RABBIT'
];

class _TakeCareScreenState extends State<TakeCareScreen> {
  Future<ConfigModel?>? futureConfigModel;
  List<ServiceModel> listServiceModels = [];
  String dropdownValue = listPetType.first;
  final descriptionController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
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

      if (configModel != null && mounted) {
        setState(() {
          listServiceModels.add(ServiceModel(
              checked: false,
              name: configModel.food1,
              price: configModel.food1Price));

          listServiceModels.add(ServiceModel(
              checked: false,
              name: configModel.food2,
              price: configModel.food2Price));

          listServiceModels.add(ServiceModel(
              checked: false,
              name: configModel.food3,
              price: configModel.food3Price));

          listServiceModels.add(ServiceModel(
              checked: false,
              name: configModel.service1,
              price: configModel.service1Price));

          listServiceModels.add(ServiceModel(
              checked: false,
              name: configModel.service2,
              price: configModel.service2Price));
        });
      }

      return configModel;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
      return null;
    }
  }

  void _showDateStartPicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(2025),
            initialDate: DateTime.now())
        .then((value) => {
              setState(() {
                startDate = value!;
              })
            });
  }

  void _showDateEndPicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(2025),
            initialDate: DateTime.now())
        .then((value) => {
              setState(() {
                endDate = value!;
              })
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      fetchData();
    });
  }

  Future<void> handleSubmit(DateTime startDate, DateTime endDate, String note,
      String dropdownValue, double totalPrice) async {
    final token = Provider.of<UserProvider>(context, listen: false).token!;
    try {
      String sDate =
          '${startDate?.year}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}';
      String eDate =
          '${endDate?.year}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}';
      print('${CommonConst.baseApiUrl}/take-care-bookings');
      dynamic response = await http
          .post(Uri.parse('${CommonConst.baseApiUrl}/take-care-bookings'),
              body: jsonEncode({
                "startDate": sDate,
                "endDate": eDate,
                "note": note,
                "petType": dropdownValue,
                "totalPrice": totalPrice,
              }),
              headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBarService.showSnackbar("Success", "success"));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndexScreen(
              currentIndex: 2,
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(listServiceModels.first.checked.toString());
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
                                title: "BOOKING-TAKE CARE",
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Start Date
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Start Date",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        width: 160,
                                        height: 150,
                                        decoration: const BoxDecoration(
                                            color: AppColors.secondary1,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    startDate.year.toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    startDate.month
                                                        .toString()
                                                        .padLeft(2, '0'),
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                    child: Center(
                                                        child: Text("-")),
                                                  ),
                                                  Text(
                                                    startDate.day
                                                        .toString()
                                                        .padLeft(2, '0'),
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: _showDateStartPicker,
                                                child: Image.asset(
                                                  "assets/images/timepicker.png",
                                                  width: 150,
                                                  height: 150,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),

                                  // End Date
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Start Date",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        width: 160,
                                        height: 150,
                                        decoration: const BoxDecoration(
                                            color: AppColors.secondary1,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    endDate.year.toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    endDate.month
                                                        .toString()
                                                        .padLeft(2, '0'),
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                    child: Center(
                                                        child: Text("-")),
                                                  ),
                                                  Text(
                                                    endDate.day
                                                        .toString()
                                                        .padLeft(2, '0'),
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: _showDateEndPicker,
                                                child: Image.asset(
                                                  "assets/images/timepicker.png",
                                                  width: 150,
                                                  height: 150,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${((config.maxPlaceTakeCare ?? 0) - (config.currentTakeCareBooking ?? 0)).toString()}",
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
                              Container(
                                  width: 310,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(
                                            0.5), // Màu của bóng đổ và độ trong suốt
                                        spreadRadius:
                                            2, // Độ lan rộng của bóng đổ
                                        blurRadius: 5, // Độ mờ của bóng đổ
                                        offset: const Offset(0,
                                            2), // Độ dịch chuyển của bóng đổ theo trục X và Y
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(30),
                                    // border: Border.all(
                                    //   color: Colors.white,
                                    // ),
                                  ),
                                  child: Center(
                                    child: DropdownButton<String>(
                                      value: dropdownValue,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      // iconSize: 30,
                                      elevation: 16,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16.0),
                                      underline: SizedBox(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                      items: listPetType
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child:
                                              // Text(value),
                                              Row(
                                            children: [
                                              Text(
                                                value,
                                                style: const TextStyle(
                                                    color: AppColors.primary),
                                              ),
                                              // Icon(Icons.arrow_drop_down),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )),

                              // Note
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                flex: 0,
                                child: Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: descriptionController,
                                        maxLines: 4, //or null
                                        decoration:
                                            const InputDecoration.collapsed(
                                                hintText:
                                                    "Enter your text here"),
                                      ),
                                    )),
                              ),

                              // Service
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Chosse food type",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // +++++ Food1 ++++++++++++ //
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20,
                                                bottom: 20,
                                                left: 10,
                                                right: 20),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(30.0)),
                                              clipBehavior: Clip.antiAlias,
                                              child: Image.network(
                                                Utils().getImageUrl(
                                                    config.food1Image!),
                                                // height: double.infinity,
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.contain,
                                                colorBlendMode:
                                                    BlendMode.overlay,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  } else {
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                },
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  // Handle the error here, for example, you can return a placeholder image
                                                  return Container(
                                                    width: 100,
                                                    height: 100,
                                                    color: Colors
                                                        .grey, // Placeholder color
                                                    child: const Icon(Icons
                                                        .error), // Placeholder icon or custom widget
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                            '${config.food1}: \$ ${config.food1Price}'),
                                        (listServiceModels.isNotEmpty)
                                            ? Checkbox(
                                                value: listServiceModels[0]
                                                    .checked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    listServiceModels[0]
                                                        .checked = value!;
                                                  });
                                                },
                                              )
                                            : const Text("dasdas")
                                      ],
                                    ),
                                  ),

                                  // +++++ Food2 ++++++++++++ //
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20,
                                                bottom: 20,
                                                left: 10,
                                                right: 20),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(30.0)),
                                              clipBehavior: Clip.antiAlias,
                                              child: Image.network(
                                                Utils().getImageUrl(
                                                    config.food2Image!),
                                                // height: double.infinity,
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.contain,
                                                colorBlendMode:
                                                    BlendMode.overlay,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  } else {
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                },
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  // Handle the error here, for example, you can return a placeholder image
                                                  return Container(
                                                    width: 100,
                                                    height: 100,
                                                    color: Colors
                                                        .grey, // Placeholder color
                                                    child: const Icon(Icons
                                                        .error), // Placeholder icon or custom widget
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                            '${config.food2}: \$ ${config.food2Price}'),
                                        (listServiceModels.isNotEmpty)
                                            ? Checkbox(
                                                value: listServiceModels[1]
                                                    .checked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    listServiceModels[1]
                                                        .checked = value!;
                                                  });
                                                },
                                              )
                                            : const Text("dasdas")
                                      ],
                                    ),
                                  ),

                                  // +++++ Food3 ++++++++++++ //
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20,
                                                bottom: 20,
                                                left: 10,
                                                right: 20),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(30.0)),
                                              clipBehavior: Clip.antiAlias,
                                              child: Image.network(
                                                Utils().getImageUrl(
                                                    config.food3Image!),
                                                // height: double.infinity,
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.contain,
                                                colorBlendMode:
                                                    BlendMode.overlay,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  } else {
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                },
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  // Handle the error here, for example, you can return a placeholder image
                                                  return Container(
                                                    width: 100,
                                                    height: 100,
                                                    color: Colors
                                                        .grey, // Placeholder color
                                                    child: const Icon(Icons
                                                        .error), // Placeholder icon or custom widget
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                            '${config.food3}: \$ ${config.food3Price}'),
                                        (listServiceModels.isNotEmpty)
                                            ? Checkbox(
                                                value: listServiceModels[2]
                                                    .checked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    listServiceModels[2]
                                                        .checked = value!;
                                                  });
                                                },
                                              )
                                            : const Text("dasdas")
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Chosse service",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // +++++ Food4 ++++++++++++ //
                                  Container(
                                    width: 130,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            '${config.service1}: \$ ${config.service1Price}'),
                                        (listServiceModels.isNotEmpty)
                                            ? Checkbox(
                                                value: listServiceModels[3]
                                                    .checked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    listServiceModels[3]
                                                        .checked = value!;
                                                  });
                                                },
                                              )
                                            : const Text("dasdas")
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  // +++++ Food5 ++++++++++++ //
                                  Container(
                                    width: 130,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            '${config.service2}: \$ ${config.service2Price}'),
                                        (listServiceModels.isNotEmpty)
                                            ? Checkbox(
                                                value: listServiceModels[4]
                                                    .checked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    listServiceModels[4]
                                                        .checked = value!;
                                                  });
                                                },
                                              )
                                            : const Text("dasdas")
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),

                              // Button booking
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.secondary1,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        // Validate first
                                        if (descriptionController.text
                                            .toString()
                                            .trim()
                                            .isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                  SnackBarService.showSnackbar(
                                                      "Please note for your pet",
                                                      "danger"));
                                          return;
                                        }

                                        if (startDate
                                            .isBefore(DateTime.now())) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                  SnackBarService.showSnackbar(
                                                      "Start date must be in the future",
                                                      "danger"));
                                          return;
                                        }

                                        if (endDate.isBefore(startDate)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                  SnackBarService.showSnackbar(
                                                      "End date must be after start date",
                                                      "danger"));
                                          return; // Kết thúc hàm nếu endDate không hợp lệ
                                        }

                                        final differenceInDays = endDate
                                            .difference(startDate)
                                            .inDays;
                                        if (differenceInDays > 30) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                  SnackBarService.showSnackbar(
                                                      "Booking period must be within 30 days",
                                                      "danger"));
                                          return; // Kết thúc hàm nếu khoảng thời gian lớn hơn 30 ngày
                                        }

                                        double totalPrice = 0;
                                        double petPrice = 5;
                                        if (dropdownValue == "SENIOR_DOG") {
                                          petPrice = 10;
                                        }

                                        totalPrice = totalPrice +
                                            (endDate
                                                        .difference(startDate)
                                                        .inDays +
                                                    1) *
                                                petPrice;

                                        String note =
                                            '${descriptionController.text.toString().trim()}, service:';

                                        if (listServiceModels.isNotEmpty) {
                                          for (int i = 0;
                                              i < listServiceModels.length;
                                              i++) {
                                            if (listServiceModels[i].checked!) {
                                              totalPrice = totalPrice +
                                                  listServiceModels[i].price!;
                                              note = note +
                                                  " " +
                                                  listServiceModels[i].name!;
                                            }
                                          }
                                        }

                                        List<dynamic> transactions = [
                                          {
                                            "amount": {
                                              "total": (totalPrice / 2)
                                                  .toStringAsFixed(2),
                                              "currency": "USD",
                                            },
                                            "description":
                                                "The payment transaction description.",
                                          }
                                        ];
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                UsePaypal(
                                                    sandboxMode: true,
                                                    clientId:
                                                        "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                                                    secretKey:
                                                        "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                                                    returnURL:
                                                        "https://samplesite.com/return",
                                                    cancelURL:
                                                        "https://samplesite.com/cancel",
                                                    transactions: transactions,
                                                    note:
                                                        "Contact us for any questions on your order.",
                                                    onSuccess:
                                                        (Map params) async {
                                                      handleSubmit(
                                                          startDate,
                                                          endDate,
                                                          note,
                                                          dropdownValue,
                                                          totalPrice);
                                                    },
                                                    onError: (error) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBarService
                                                                  .showSnackbar(
                                                                      error
                                                                          .toString(),
                                                                      "danger"));
                                                    },
                                                    onCancel: (params) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBarService
                                                                  .showSnackbar(
                                                                      "Cancel",
                                                                      "danger"));
                                                    }),
                                          ),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: AppColors.secondary1,
                                        foregroundColor: Colors.white,
                                        shape: const BeveledRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(1),
                                          ),
                                        ),
                                      ),
                                      child: const Text('Checkout',
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Brand(
                                      Brands.paypal,
                                      size: 50,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ),

                        // DropdownButton<String>(
                        //   value: dropdownValue,
                        //   icon: const Icon(Icons.arrow_downward),
                        //   elevation: 16,
                        //   style: const TextStyle(color: Colors.deepPurple),
                        //   underline: Container(
                        //     height: 2,
                        //     color: Colors.deepPurpleAccent,
                        //   ),
                        //   onChanged: (String? value) {
                        //     // This is called when the user selects an item.
                        //     setState(() {
                        //       dropdownValue = value!;
                        //     });
                        //   },
                        //   items: listPetType
                        //       .map<DropdownMenuItem<String>>((String value) {
                        //     return DropdownMenuItem<String>(
                        //       value: value,
                        //       child: Text(value),
                        //     );
                        //   }).toList(),
                        // ),
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
          }),
    ));
  }
}
