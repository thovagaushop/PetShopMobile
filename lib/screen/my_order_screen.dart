import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/models/order_model.dart';
import 'package:test_flutter_2/services/order/order_service.dart';
import 'package:test_flutter_2/services/snackBar/snackbar_service.dart';
import 'package:test_flutter_2/widgets/Icons/circle_icon.dart';
import 'package:test_flutter_2/widgets/MyOrder/my_order_body_widget.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  Future<List<OrderModel>>? futureOrderModels;

  void updateItems() {
    setState(() {
      futureOrderModels = fetchOrderModels();
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
      futureOrderModels = fetchOrderModels();
    });
  }

  Future<List<OrderModel>> fetchOrderModels() async {
    String token = Provider.of<UserProvider>(context, listen: false).token!;
    try {
      List<OrderModel> orderModels = await OrderService().fetchOrders(token);

      if (!context.mounted) return [];

      return orderModels;
    } catch (e) {
      print(e);
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
      body: FutureBuilder<List<OrderModel>>(
        future: futureOrderModels,
        builder: (context, data) {
          if (data.hasData) {
            List<OrderModel> orders = data.data!;
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
                        "My orders",
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
                    child: MyOrderBodyWidget(
                        orderModels: orders,
                        onUpdate: () {
                          updateItems();
                        }),
                  ),
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
    ));
  }
}
