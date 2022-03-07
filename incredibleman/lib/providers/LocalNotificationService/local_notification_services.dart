import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// this is for LocalNotification for both Android and IOS
class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    // this is initialzation for notification  for Android and IOS
    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: IOSInitializationSettings());

    ///new one added here
    //this is configration for android notification channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'FLUTTER_NOTIFICATION_CLICK', "IM notification",
        importance: Importance.high, playSound: true);

    _notification.initialize(initializationSettings);

    ///new one added here
    //implemented platform channel
    _notification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

// this static function will display remote notification
  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      // here is the details of noftification channel for android and default IOS

      NotificationDetails notificationDetails = const NotificationDetails(
        // don't forget to pass notification channel name to notification data
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

      // this show method will trigger when notification comes

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
