import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/cart_provider.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/cart_model.dart';
import 'package:test_flutter_2/screen/checkout_screen.dart';
import 'package:test_flutter_2/services/cart/cart_service.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/widgets/Cart/cart_body.dart';
import 'package:test_flutter_2/widgets/Header/main_header.dart';
import 'package:test_flutter_2/widgets/Icons/circle_icon.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<List<CartModel>>? futureCartModels;

  void updateItems() {
    setState(() {
      futureCartModels = fetchCartProducts();
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
                              "Cart",
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
                          child: CartBodyWidget(
                              cartModels: cartModels,
                              onUpdate: () {
                                updateItems();
                              }),
                        ),
                      ],
                    ));
              } else if (data.hasError) {
                return Text('Error: ${data.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
        bottomNavigationBar: Container(
          height: 90,
          decoration: const BoxDecoration(
              color: AppColors.mainColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(97, 97, 97, 1),
                    blurRadius: 1,
                    spreadRadius: 1.0,
                    offset: Offset(1.0, 1.0))
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    children: [
                      const Text('Total'),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<List<CartModel>>(
                        future: futureCartModels,
                        builder: (context, data) {
                          if (data.hasData) {
                            List<CartModel> cartModels = data.data!;

                            double totalPrice = 0;
                            for (int i = 0; i < cartModels.length; i++) {
                              totalPrice += cartModels[i].productSpecialPrice! *
                                  cartModels[i].quantity!;
                            }

                            return Expanded(
                              child: Text(
                                '\$ ${totalPrice.abs().toString()}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.clip),
                              ),
                            );
                          } else if (data.hasError) {
                            return Text('Error: ${data.error}');
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CheckoutScreen()))
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
