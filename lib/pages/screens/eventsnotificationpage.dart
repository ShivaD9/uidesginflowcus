import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> notificationList = [];
  String notificationMsg = "Waiting for notifications";

  @override
  void initState() {
    super.initState();

    LocalNotificationService.initialize();

    // Terminated State
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        setState(() {
          notificationMsg =
          "${event.notification!.title} ${event.notification!.body} I am coming from the terminated state";
          notificationList.add(notificationMsg);
        });
      }
    });

    // Foreground State
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      setState(() {
        notificationMsg =
        "${event.notification!.title} ${event.notification!.body} I am coming from the foreground";
        notificationList.add(notificationMsg);
      });
    });

    // Background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        notificationMsg =
        "${event.notification!.title} ${event.notification!.body} I am coming from the background";
        notificationList.add(notificationMsg);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Notifications"),
      ),
      body: ListView.builder(
        itemCount: notificationList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notificationList[index]),
          );
        },
      ),
    );
  }
}

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(initializationSettings);
  }

  static void showNotificationOnForeground(RemoteMessage message) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'com.example.uidesginpage',
      'uidesginpage',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    _notificationsPlugin.show(
      DateTime.now().microsecond,
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
      payload: message.data["message"],
    );
  }
}
