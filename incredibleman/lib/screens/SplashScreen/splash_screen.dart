import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/screens/Home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 9), () {
      Get.offAll(() => const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Image.asset(
            splashScreen,
            fit: BoxFit.fitWidth,
            width: 250,
          ),
        )),
      ),
    );
  }
}
