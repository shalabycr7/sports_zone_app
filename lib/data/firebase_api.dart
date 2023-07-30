import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBack(RemoteMessage messege) async {
  print('title ${messege.notification?.title}');
  print('body ${messege.notification?.body}');

  print('payload ${messege.data}');
}

class FireBaseApi {
  final fireMes = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
    'high importance channel',
    'high importance noto=ofication',
    description: 'notification channel',
    importance: Importance.defaultImportance,
  );
  final _localNotify = FlutterLocalNotificationsPlugin();

  Future<void> intitNot() async {
    await fireMes.requestPermission();
    final fCTok = await fireMes.getToken();
    print(fCTok);
    FirebaseMessaging.onBackgroundMessage(handleBack);
  }
}
