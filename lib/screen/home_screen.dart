import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_2/controllers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserPorvider>(context);
    print(provider.token.toString());
    return const Scaffold(
      body: Text("Home Screen"),
    );
  }
}
