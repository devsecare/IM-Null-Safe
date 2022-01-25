// ignore_for_file: constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:incredibleman/providers/LocalNotificationService/local_notification_services.dart';
import 'package:incredibleman/providers/carttestModel/cartbox.dart';
import 'package:incredibleman/screens/SplashScreen/splash_screen.dart';

import 'providers/providerdata.dart';

const String Cart_Items = "cart";
const String FavList = "fav";
const String TestBox = "TestBox";
// final bool nav = false;

Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // ignore: avoid_print
  print("aa background ${message.data.toString()}");

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  // LocalNotificationService.display(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartBoxAdapter());
  await Hive.openBox(Cart_Items);
  await Hive.openBox(FavList);
  await Hive.openBox(TestBox);
  LocalNotificationService.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final cro = Get.put(CartData());
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.white),
          // centerTitle: true,
          color: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Incredible man ',
      home: const SplashScreen(),
    );
  }
}
