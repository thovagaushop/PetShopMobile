import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/models/product_model.dart';

class ProductDetailBody extends StatefulWidget {
  final ProductModel product;
  const ProductDetailBody({super.key, required this.product});

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
            height: 300,
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
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title.toString(),
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "\$ ${widget.product.specialPrice}",
                  style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.product.description.toString(),
                  style: const TextStyle(
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
      margin: const EdgeInsets.only(left: 30, right: 30),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          widget.product.images![0],
          // height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
          colorBlendMode: BlendMode.overlay,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(child: CircularProgressIndicator()));
            }
          },
        ),
      ),
    );
  }
}
