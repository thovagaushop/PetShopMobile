import 'package:flutter/material.dart';
import 'package:test_flutter_2/models/product_model.dart';
import 'package:test_flutter_2/services/products/product_service.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/widgets/Product/product_card.dart';

class ProductGridWidget extends StatefulWidget {
  const ProductGridWidget({Key? key}) : super(key: key);

  @override
  State<ProductGridWidget> createState() => _ProductGridWidgetState();
}

class _ProductGridWidgetState extends State<ProductGridWidget> {
  Future<List<ProductModel>>? futureProductModels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      fetchData();
    });
  }

  void fetchData() {
    setState(() {
      futureProductModels = fetchProducts();
    });
  }

  Future<List<ProductModel>> fetchProducts() async {
    try {
      List<ProductModel> productModels =
          await ProductService().fetchListProducts();
      if (!context.mounted) return [];
      return productModels;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarService.showSnackbar(e.toString(), "danger"));
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
        future: futureProductModels,
        builder: (context, data) {
          if (data.hasData) {
            final products = data.data!;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                children: [
                  SizedBox(
                    height: 550,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 2 / 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemCount: products.length,
                      itemBuilder: (context, index) =>
                          ProductCardWidget(product: products[index]),
                    ), // Height constraint for the GridView
                    // child: GridView.count(
                    //   shrinkWrap: true,
                    //   crossAxisCount: 2,
                    //   children: List.generate(products.length, (index) {
                    //     return ProductCardWidget(
                    //       product: products[index],
                    //     );
                    //   }),
                    // ),
                  ),
                ],
              ),
            );
          } else if (data.hasError) {
            return Text(data.error.toString());
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
