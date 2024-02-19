import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/cart_provider.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/cart_model.dart';
import 'package:test_flutter_2/screen/cart_screen.dart';
import 'package:test_flutter_2/screen/login_screen.dart';
import 'package:test_flutter_2/services/cart/cart_service.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/widgets/Icons/circle_icon.dart';

class MainHeaderWidget extends StatefulWidget {
  final bool hasLeftIcon;
  final String headerText;
  const MainHeaderWidget(
      {super.key, required this.hasLeftIcon, this.headerText = "Petty"});

  @override
  State<MainHeaderWidget> createState() => _MainHeaderWidgetState();
}

class _MainHeaderWidgetState extends State<MainHeaderWidget> {
  Future<List<CartModel>>? futureCartModels;

  @override
  void initState() {
    super.initState();
    // Defer the execution of fetchData until after the first frame
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      fetchData();
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
      futureCartModels = fetchCartProducts(token);
    });
  }

  Future<List<CartModel>> fetchCartProducts(String token) async {
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBarService.showSnackbar("You need to login first !!", "danger"));
    }
    try {
      CartProvider cartProvider =
          Provider.of<CartProvider>(context, listen: false);
      cartProvider.clearCart();

      List<CartModel> cartModels = await CartService().fetchCartProduct(token);

      for (CartModel model in cartModels) {
        cartProvider.addItem(model);
      }
      if (!context.mounted) return [];

      return cartModels;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CartModel>>(
        future: futureCartModels,
        builder: (context, data) {
          if (data.hasData) {
            final cartProvider = Provider.of<CartProvider>(context);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50,
                  child: widget.hasLeftIcon
                      ? InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const CircleIconCustom(
                            icon: Icons.arrow_back_ios_new,
                            iconSize: 18,
                          ),
                        )
                      : null,
                ),
                Text(
                  widget.headerText,
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                  },
                  child: CircleIconCustom(
                    icon: Icons.shopping_basket,
                    iconSize: 22,
                    isBadge: true,
                    numberBadge: cartProvider.itemCount,
                  ),
                )
              ],
            );
          } else if (data.hasError) {
            return Text("${data.error}");
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50,
                  child: widget.hasLeftIcon
                      ? InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const CircleIconCustom(
                            icon: Icons.arrow_back_ios_new,
                            iconSize: 18,
                          ),
                        )
                      : null,
                ),
                Text(
                  widget.headerText,
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: const CircleIconCustom(
                    icon: Icons.shopping_basket,
                    iconSize: 22,
                    isBadge: true,
                    numberBadge: 0,
                  ),
                )
              ],
            );
          }
        });
  }
}
