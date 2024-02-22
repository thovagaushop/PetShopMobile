import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/profile_model.dart';
import 'package:test_flutter_2/models/user_model.dart';
import 'package:test_flutter_2/screen/index.dart';
import 'package:test_flutter_2/services/Profile/profile_service.dart';
import 'package:test_flutter_2/services/authentication/authentication_service.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/widgets/Header/main_header.dart';
import 'package:test_flutter_2/widgets/TextField/text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<ProfileModel?>? futureProfileModel;
  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();

  String date = "";
  String time = "";
  String description = "";

  void fetchData() {
    setState(() {
      futureProfileModel = fetchProfile();
    });
  }

  Future<ProfileModel?> fetchProfile() async {
    final token = Provider.of<UserProvider>(context, listen: false).token!;
    try {
      ProfileModel profileModel = await ProfileService().fetchModel(token);
      emailController.text = profileModel.email!;
      firstnameController.text = profileModel.firstname!;
      lastnameController.text = profileModel.lastname!;
      phoneNumberController.text = profileModel.phoneNumber!;
      addressController.text = profileModel.address!;
      if (!context.mounted) return null;

      return profileModel;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
      return null;
    }
  }

  Future<void> handleSubmit(String? email, String? firstname, String? lastname,
      String? phoneNumber, String? address, String? password) async {
    ProfileModel newProfile = ProfileModel(
      email: email,
      firstname: firstname,
      lastname: lastname,
      phoneNumber: phoneNumber,
      address: address,
    );

    try {
      final token = Provider.of<UserProvider>(context, listen: false).token!;
      String message = await ProfileService().updateProfile(newProfile, token);

      // Login again
      final provider = Provider.of<UserProvider>(context, listen: false);
      dynamic response = await AuthenticationService.login(email, password);
      if (!context.mounted) return;
      provider.login(UserModel.fromJson(response));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(message, "success"));

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const IndexScreen(
                    currentIndex: 3,
                  )));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
    }
    // if (date.isEmpty || time.isEmpty || description.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBarService.showSnackbar("Please fill all fields", "danger"));
    //   return;
    // }
    // try {
    //   final token = Provider.of<UserProvider>(context, listen: false).token!;
    //   String message = await ExaminationService()
    //       .createBooking(token, '${date}T${time}:00.000+07:00', description);
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBarService.showSnackbar(message, "success"));

    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => IndexScreen(
    //         currentIndex: 2,
    //       ),
    //     ),
    //   );
    //   return;
    // } catch (e) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
    //   return;
    // }
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
            body: FutureBuilder<ProfileModel?>(
                future: futureProfileModel,
                builder: (context, data) {
                  if (data.hasData) {
                    ProfileModel? profileModel = data.data;

                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const MainHeaderWidget(hasLeftIcon: false),
                            const Center(
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                                flex: 0,
                                child: TextFieldCustom(
                                  controller: emailController,
                                  hintText: "Email",
                                  obscureText: false,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                                flex: 0,
                                child: TextFieldCustom(
                                  controller: firstnameController,
                                  hintText: "First name",
                                  obscureText: false,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                                flex: 0,
                                child: TextFieldCustom(
                                  controller: lastnameController,
                                  hintText: "Last name",
                                  obscureText: false,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                                flex: 0,
                                child: TextFieldCustom(
                                  controller: phoneNumberController,
                                  hintText: "Phone Number",
                                  obscureText: false,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                                flex: 0,
                                child: TextFieldCustom(
                                  controller: addressController,
                                  hintText: "Address",
                                  obscureText: false,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                                flex: 0,
                                child: TextFieldCustom(
                                  controller: passwordController,
                                  hintText: "Confirm",
                                  obscureText: true,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () => {
                                handleSubmit(
                                    emailController.text.toString().trim(),
                                    firstnameController.text.toString().trim(),
                                    lastnameController.text.toString().trim(),
                                    phoneNumberController.text
                                        .toString()
                                        .trim(),
                                    addressController.text.toString().trim(),
                                    passwordController.text.toString().trim())
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 70),
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
                    );
                  } else if (data.hasError) {
                    return Text('Error: ${data.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })));
  }
}
