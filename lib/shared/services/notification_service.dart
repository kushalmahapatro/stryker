import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stryker/stryker.dart';

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) {
  debugPrint('id $id');
}

Future<void> notificationService() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  if (!kIsWeb) {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');

  const IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);

  const MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (payload) {
      if (payload != null && payload.isNotEmpty) {
        behaviorSubject.add({'data': payload, 'type': 1});
      }
    },
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null && message.notification?.android != null) {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
            ),
          ),
          payload: message.data['id'] ?? '');

      behaviorSubject.add({'data': message.data['id'] ?? '', 'type': 0});
    }
  });

  final details =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (details != null && details.didNotificationLaunchApp) {
    behaviorSubject.add({'data': details.payload!, 'type': 0});
  }
}
