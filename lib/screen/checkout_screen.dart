import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/cart_model.dart';
import 'package:test_flutter_2/services/cart/cart_service.dart';
import 'package:test_flutter_2/services/order/order_service.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/widgets/Icons/circle_icon.dart';
import 'package:test_flutter_2/widgets/TextField/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Future<List<CartModel>>? futureCartModels;
  final addressController = TextEditingController();
  String address = "";
  bool isPaypal = false;

  void fetchData() {
    final token = Provider.of<UserProvider>(context, listen: false).token;
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarService.showSnackbar("You need to login first !!", "danger"),
      );
      return;
    }
    setState(() {
      futureCartModels = fetchCartProducts();
    });
  }

  Future<List<CartModel>> fetchCartProducts() async {
    String token = Provider.of<UserProvider>(context, listen: false).token!;
    try {
      List<CartModel> cartModels = await CartService().fetchCartProduct(token);

      if (!context.mounted) return [];

      return cartModels;
    } catch (e) {
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

  Future<void> createOrder(address, paymentMethod) async {
    // if (address.isEmpty()) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBarService.showSnackbar("Address required", "error"));
    //   return;
    // }

    // print(address.isEmpty());
    final token = Provider.of<UserProvider>(context, listen: false).token!;
    print("toekn : " + token);
    try {
      String response =
          await OrderService().createOrder(token, address, paymentMethod);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(response, "success"));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: FutureBuilder<List<CartModel>>(
          future: futureCartModels,
          builder: (context, data) {
            if (data.hasData) {
              List<CartModel> cartModels = data.data!;

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
                          "Checkout",
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
                        child: TextFieldCustom(
                            hintText: "Address",
                            controller: addressController,
                            obscureText: false)),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text(
                        "Pay by Paypal :",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Checkbox(
                        value: isPaypal,
                        onChanged: (bool? value) {
                          setState(() {
                            isPaypal = value!;
                          });
                        },
                      )
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        flex: 0,
                        child: isPaypal &&
                                addressController.text
                                    .toString()
                                    .trim()
                                    .isNotEmpty
                            ? Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        double totalPrice = 0;
                                        for (int i = 0;
                                            i < cartModels.length;
                                            i++) {
                                          totalPrice += cartModels[i]
                                                  .productSpecialPrice! *
                                              cartModels[i].quantity!;
                                        }

                                        List<dynamic> transactions = [
                                          {
                                            "amount": {
                                              "total":
                                                  totalPrice.toStringAsFixed(2),
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
                                                      createOrder(
                                                          addressController.text
                                                              .toString()
                                                              .trim(),
                                                          "CREDIT_CARD");
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
                            : TextButton(
                                onPressed: () {
                                  createOrder(
                                      addressController.text.toString().trim(),
                                      "CAST");
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
                                child: const Text("Checkout By Cast")))
                  ],
                ),
              );
            } else if (data.hasError) {
              return Text('Error: ${data.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
