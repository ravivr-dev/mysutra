import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_sutra/core/utils/app_helper.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  final localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> intiNotifications() async {
    await _fcm.requestPermission();
    await forgroundMessage();
  }

  Future<void> forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            _androidChannel.id, _androidChannel.name,
            channelDescription: _androidChannel.description,
            playSound: _androidChannel.playSound,
            icon: '@mipmap/ic_launcher'));

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      message.log(name: 'notification on opened Application');
      final notificaton = message.notification;
      if (notificaton == null) return;

      localNotifications.show(
        notificaton.hashCode,
        notificaton.title,
        notificaton.body,
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    });

    FirebaseMessaging.onMessage.listen((message) {
      message.log(name: 'notification on normal flow');

      final notificaton = message.notification;
      if (notificaton == null) return;

      localNotifications.show(
        notificaton.hashCode,
        notificaton.title,
        notificaton.body,
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    });
  }

  Future intiLocalNotifications() async {
    const iOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);
    const android = AndroidInitializationSettings('drawable/ic_launcher');

    const settings = InitializationSettings(android: android, iOS: iOS);

    await localNotifications.initialize(
      settings,
      // onDidReceiveBackgroundNotificationResponse:
      // onDidReceiveNotificationResponse:

      // onDidReceiveBackgroundNotificationResponse: (data) {
      /// this method will work when click on notification,
      //   final message = RemoteMessage.fromMap(jsonDecode(data.payload!));
      //   log(message.notification?.title ?? '');
      // },
    );
  }

  /////////

  // Future initialize() async {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Got a message whilst in the foreground!');
  //     print('Message data: ${message.data}');

  //     if (message.notification != null) {
  //       print('Message also contained a notification: ${message.notification}');
  //     }
  //   });
  // }

  // Future<String?> getToken() async {
  //   String? token = await _fcm.getToken();
  //   print('Token: $token');
  //   return token;
  // }
}
