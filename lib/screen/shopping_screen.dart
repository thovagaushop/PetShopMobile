import 'package:flutter/material.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/models/product_model.dart';
import 'package:test_flutter_2/screen/cart_screen.dart';
import 'package:test_flutter_2/screen/home_screen.dart';
import 'package:test_flutter_2/widgets/Header/main_header.dart';
import 'package:test_flutter_2/widgets/Icons/circle_icon.dart';
import 'package:test_flutter_2/widgets/Product/product_card.dart';
import 'package:test_flutter_2/widgets/Product/product_grid.dart';
import 'package:test_flutter_2/widgets/TextField/text_buidler.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const MainHeaderWidget(hasLeftIcon: false),
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     SizedBox(
              //       width: 50,
              //     ),
              //     Text(
              //       "Petty",
              //       style: TextStyle(
              //           color: AppColors.primary,
              //           fontSize: 32,
              //           fontWeight: FontWeight.w300,
              //           fontStyle: FontStyle.italic),
              //     ),
              //     CircleIconCustom(icon: Icons.shopping_basket)
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(0, 0),
                                blurRadius: 8)
                          ]),
                      child: TextField(
                        autofocus: false,
                        onSubmitted: (val) {},
                        onChanged: (val) {},
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 16),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none),
                            hintText: "Search...",
                            prefixIcon: const Icon(Icons.search)),
                      ),
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Expanded(
                child: ProductGridWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
