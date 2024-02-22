import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/common/constant/common.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/config_model.dart';
import 'package:test_flutter_2/models/service_select_model.dart';
import 'package:test_flutter_2/screen/pet_service_screen.dart';
import 'package:test_flutter_2/services/bookingConfig/config_service.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/utils/utils.dart';
import 'package:test_flutter_2/widgets/Header/main_header.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:http/http.dart' as http;

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
          listServiceModels = [
            ServiceModel(
                checked: false,
                name: configModel.food1,
                price: configModel.food1Price),
            ServiceModel(
                checked: false,
                name: configModel.food2,
                price: configModel.food2Price),
            ServiceModel(
                checked: false,
                name: configModel.food3,
                price: configModel.food3Price),
            ServiceModel(
                checked: false,
                name: configModel.service1,
                price: configModel.service1Price),
            ServiceModel(
                checked: false,
                name: configModel.service2,
                price: configModel.service2Price),
          ];
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

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PetServiceScreen()));
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
                        const MainHeaderWidget(hasLeftIcon: false),
                        const Center(
                          child: Text(
                            "Form booking an take care",
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
                          child: Text(
                            'Available slot: ${((config.maxPlaceTakeCare ?? 0) - (config.currentTakeCareBooking ?? 0)).toString()}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MaterialButton(
                              onPressed: _showDateStartPicker,
                              color: AppColors.primary,
                              child: const Text(
                                'Choose Start Date',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(startDate.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      overflow: TextOverflow.clip)),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MaterialButton(
                              onPressed: _showDateEndPicker,
                              color: AppColors.primary,
                              child: const Text(
                                'Choose End Date',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(endDate.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      overflow: TextOverflow.clip)),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Select Pet Type"),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: listPetType
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        Expanded(
                          flex: 0,
                          child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: descriptionController,
                                  maxLines: 4, //or null
                                  decoration: const InputDecoration.collapsed(
                                      hintText: "Enter your text here"),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text("Chosse food type"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // +++++ Food1 ++++++++++++ //
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.mainColorFocus,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30.0)),
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.network(
                                          Utils()
                                              .getImageUrl(config.food1Image!),
                                          // height: double.infinity,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.contain,
                                          colorBlendMode: BlendMode.overlay,
                                          loadingBuilder: (BuildContext context,
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
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            // Handle the error here, for example, you can return a placeholder image
                                            return Container(
                                              width: 100,
                                              height: 100,
                                              color: Colors
                                                  .grey, // Placeholder color
                                              child: Icon(Icons
                                                  .error), // Placeholder icon or custom widget
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                      '${config.food1}: \$ ${config.food1Price}'),
                                  (listServiceModels.length > 0)
                                      ? Checkbox(
                                          value: listServiceModels[0].checked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              listServiceModels[0].checked =
                                                  value!;
                                            });
                                          },
                                        )
                                      : Text("dasdas")
                                ],
                              ),
                            ),

                            // +++++ Food2 ++++++++++++ //
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.mainColorFocus,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30.0)),
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.network(
                                          Utils()
                                              .getImageUrl(config.food2Image!),
                                          // height: double.infinity,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.contain,
                                          colorBlendMode: BlendMode.overlay,
                                          loadingBuilder: (BuildContext context,
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
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            // Handle the error here, for example, you can return a placeholder image
                                            return Container(
                                              width: 100,
                                              height: 100,
                                              color: Colors
                                                  .grey, // Placeholder color
                                              child: Icon(Icons
                                                  .error), // Placeholder icon or custom widget
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                      '${config.food2}: \$ ${config.food2Price}'),
                                  (listServiceModels.length > 0)
                                      ? Checkbox(
                                          value: listServiceModels[1].checked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              listServiceModels[1].checked =
                                                  value!;
                                            });
                                          },
                                        )
                                      : Text("dasdas")
                                ],
                              ),
                            ),

                            // +++++ Food3 ++++++++++++ //
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.mainColorFocus,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30.0)),
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.network(
                                          Utils()
                                              .getImageUrl(config.food3Image!),
                                          // height: double.infinity,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.contain,
                                          colorBlendMode: BlendMode.overlay,
                                          loadingBuilder: (BuildContext context,
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
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            // Handle the error here, for example, you can return a placeholder image
                                            return Container(
                                              width: 100,
                                              height: 100,
                                              color: Colors
                                                  .grey, // Placeholder color
                                              child: Icon(Icons
                                                  .error), // Placeholder icon or custom widget
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                      '${config.food3}: \$ ${config.food3Price}'),
                                  (listServiceModels.length > 0)
                                      ? Checkbox(
                                          value: listServiceModels[2].checked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              listServiceModels[2].checked =
                                                  value!;
                                            });
                                          },
                                        )
                                      : Text("dasdas")
                                ],
                              ),
                            )
                          ],
                        ),
                        Text("Chosse service type"),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // +++++ Food4 ++++++++++++ //
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: AppColors.mainColorFocus,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      '${config.service1}: \$ ${config.service1Price}'),
                                  (listServiceModels.length > 0)
                                      ? Checkbox(
                                          value: listServiceModels[3].checked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              listServiceModels[3].checked =
                                                  value!;
                                            });
                                          },
                                        )
                                      : Text("dasdas")
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // +++++ Food5 ++++++++++++ //
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: AppColors.mainColorFocus,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      '${config.service2}: \$ ${config.service2Price}'),
                                  (listServiceModels.length > 0)
                                      ? Checkbox(
                                          value: listServiceModels[4].checked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              listServiceModels[4].checked =
                                                  value!;
                                            });
                                          },
                                        )
                                      : Text("dasdas")
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  double totalPrice = 0;
                                  double petPrice = 5;
                                  if (dropdownValue == "SENIOR_DOG") {
                                    petPrice = 10;
                                  }

                                  totalPrice = totalPrice +
                                      (endDate.difference(startDate).inDays +
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
                                        "total":
                                            (totalPrice / 2).toStringAsFixed(2),
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
                                              onSuccess: (Map params) async {
                                                handleSubmit(
                                                    startDate,
                                                    endDate,
                                                    note,
                                                    dropdownValue,
                                                    totalPrice);
                                              },
                                              onError: (error) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        SnackBarService
                                                            .showSnackbar(
                                                                error
                                                                    .toString(),
                                                                "danger"));
                                              },
                                              onCancel: (params) {
                                                ScaffoldMessenger.of(context)
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
                                  backgroundColor: AppColors.secondary,
                                  foregroundColor: Colors.white,
                                  shape: const BeveledRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(1),
                                    ),
                                  ),
                                ),
                                child: const Text('Checkout'),
                              ),
                              Brand(
                                Brands.paypal,
                                size: 50,
                              )
                            ],
                          ),
                        )
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
