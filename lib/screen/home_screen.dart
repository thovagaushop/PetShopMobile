import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/screen/index.dart';
import 'package:test_flutter_2/screen/shopping_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    print(provider.token.toString());
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "WELCOME",
                style: TextStyle(
                    color: AppColors.mainColorFocus,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Shopping now",
                style: TextStyle(
                    color: AppColors.mainColorFocus,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IndexScreen(
                                  currentIndex: 1,
                                )));
                  },
                  child: Image.asset(
                    'assets/images/image_home.gif', // Replace with the path to your image asset
                    width: 300, // Optional: Set the width of the image
                    height: 300, // Optional: Set the height of the image
                    fit: BoxFit
                        .cover, // Optional: Set how the image should be inscribed into the space
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Service for your Pet",
                style: TextStyle(
                    color: AppColors.mainColorFocus,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IndexScreen(
                                  currentIndex: 2,
                                )));
                  },
                  child: Image.asset(
                    'assets/images/image_home2.gif', // Replace with the path to your image asset
                    width: 300, // Optional: Set the width of the image
                    height: 300, // Optional: Set the height of the image
                    fit: BoxFit
                        .cover, // Optional: Set how the image should be inscribed into the space
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
