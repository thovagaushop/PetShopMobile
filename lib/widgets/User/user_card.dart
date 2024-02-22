import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/screen/home_screen.dart';
import 'package:test_flutter_2/screen/login_screen.dart';
import 'package:test_flutter_2/screen/my_examination_screen.dart';
import 'package:test_flutter_2/screen/my_order_screen.dart';
import 'package:test_flutter_2/screen/my_take_care_screen.dart';

class UserCardWidget extends StatelessWidget {
  final Icon icon;
  final String toPath;
  const UserCardWidget({super.key, required this.toPath, required this.icon});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    void hanleClick() {
      if (toPath == "profile") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else if (toPath == "orders") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyOrderScreen()));
      } else if (toPath == "examinations") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyExaminationScreen()));
      } else if (toPath == "takecares") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyTakeCareScreen()));
      } else if (toPath == "logout") {
        provider.logout();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
        child: InkWell(
          onTap: () => {hanleClick()},
          child: Container(
            height: 100,
            width: double.maxFinite,
            decoration: const BoxDecoration(
                color: AppColors.mainColorFocus,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Center(
                child: Text(
              toPath,
              style: const TextStyle(
                  fontSize: 30,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ),
    );
  }
}
