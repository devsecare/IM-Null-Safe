import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: IOSInitializationSettings());

    ///new one added here
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'FLUTTER_NOTIFICATION_CLICK', "IM notification",
        importance: Importance.high, playSound: true);

    _notification.initialize(initializationSettings);

    ///new one added here
    _notification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      print("aa kyre thai che");

      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
          "FLUTTER_NOTIFICATION_CLICK",
          "IM notification",
          channelDescription: "This is Our channel",
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: true,
          // onlyAlertOnce: true,
        ),
        iOS: IOSNotificationDetails(),
      );

      await _notification.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
