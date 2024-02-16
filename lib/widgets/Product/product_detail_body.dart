import 'dart:ffi';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_2/common/constant.dart';

class ProductDetailBody extends StatefulWidget {
  const ProductDetailBody({super.key});

  @override
  State<ProductDetailBody> createState() => _ProductDetailBodyState();
}

class _ProductDetailBodyState extends State<ProductDetailBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DotsIndicator(
          dotsCount: 3,
          position: _currentPageValue,
          decorator: const DotsDecorator(
            activeColor: AppColors.primary,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        // Image
        Stack(children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: pageController,
              itemCount: 3,
              itemBuilder: (context, index) {
                return _builderPageItem(index);
              },
            ),
          ),
        ]),
        // Name, Price and Description
        Container(
          height: 170,
          width: double.maxFinite,
          margin: const EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: const Padding(
            padding: EdgeInsets.only(left: 10, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product name",
                  style: TextStyle(color: AppColors.primary, fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "100 \$",
                  style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _builderPageItem(int index) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: const DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage("assets/images/product5.jpg"))),
    );
  }
}
