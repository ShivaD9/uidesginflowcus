import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'demo2.dart';

class Pagecontact extends StatefulWidget {
  @override
  _PagecontactState createState() => _PagecontactState();
}

class _PagecontactState extends State<Pagecontact> {

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
  Future<void> _refreshData() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers Contact'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: notificationList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(notificationList[index]),
            );
          },
        ),
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

