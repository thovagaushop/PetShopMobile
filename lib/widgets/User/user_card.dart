import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/common/constant/app_color.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';
import 'package:test_flutter_2/screen/login_screen.dart';
import 'package:test_flutter_2/screen/my_examination_screen.dart';
import 'package:test_flutter_2/screen/my_order_screen.dart';
import 'package:test_flutter_2/screen/my_take_care_screen.dart';
import 'package:test_flutter_2/screen/profile_screen.dart';

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
            MaterialPageRoute(builder: (context) => const ProfileScreen()));
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
        padding: const EdgeInsets.only(right: 15, left: 15, top: 43),
        child: InkWell(
          onTap: () => {hanleClick()},
          child: Container(
              height: 70,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColors.secondary1,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.5), // Màu của bóng đổ và độ trong suốt
                    spreadRadius: 2, // Độ lan rộng của bóng đổ
                    blurRadius: 5, // Độ mờ của bóng đổ
                    offset: const Offset(
                        0, 2), // Độ dịch chuyển của bóng đổ theo trục X và Y
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                        toPath.toLowerCase().replaceAllMapped(
                            RegExp(r'^\w|(?<=\s)\w'),
                            (match) => match.group(0)!.toUpperCase()),
                        style: const TextStyle(
                            fontSize: 28,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Transform.rotate(
                        angle: 35 * 3.1415926535 / 180,
                        child: const Icon(
                          Icons.pets,
                          size: 30,
                          color: AppColors.secondaryFocus,
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
