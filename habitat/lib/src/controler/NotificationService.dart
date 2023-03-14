import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:habitat/src/controler/ReadController.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import '../routes/routes.dart';

class CustomNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  CustomNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}

class NotificationService {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  late AndroidNotificationDetails _androidNotificationDetails;
  ReadController readController = ReadController();

  NotificationService() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }
  _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotifications();
  }

  Future<void> _setupTimezone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    await _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
      onSelectNotification: (payload) async {
        if (payload != null) {
          print('notification payload: ' + payload);
        }
      },
    );
  }

  _onSelectNotification(String? payload) async {
    if (payload != null && payload.isNotEmpty) {
      //search database for id and navigate to that page

      readController.question.id = payload;

      Navigator.of(Routes.navigatorKey!.currentContext!).pushNamed('/questionView');
    }
  }

  showNotification(CustomNotification notification) {
    _androidNotificationDetails = const AndroidNotificationDetails(
      'pergunta_respondida',
      'respondida',
      importance: Importance.max,
      priority: Priority.max,
    );

    _flutterLocalNotificationsPlugin.show(
        notification.id,
        notification.title,
        notification.body,
        NotificationDetails(
          android: _androidNotificationDetails,
        ),
        payload: notification.payload);
  }

  checkForNotification() async {
    final details = await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      if (details.payload != null && details.didNotificationLaunchApp) {
        _onSelectNotification(details.payload);
      }
    }
  }
}
