import 'package:flutter/material.dart';
import 'package:test_flutter_2/widgets/User/user_card.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listScreen = [
      {
        'icon': Icon(Icons.person),
        'toPath': "profile",
      },
      {
        'icon': Icon(Icons.settings),
        'toPath': "orders",
      },
      {
        'icon': Icon(Icons.settings),
        'toPath': "examinations",
      },
      {
        'icon': Icon(Icons.settings),
        'toPath': "takecares",
      },
      {
        'icon': Icon(Icons.settings),
        'toPath': "logout",
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
          children: [
            SizedBox(
                height: 650,
                child: ListView.separated(
                  padding: const EdgeInsets.all(5),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return UserCardWidget(
                      icon: listScreen[index]['icon'],
                      toPath: listScreen[index]['toPath'],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 10,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
