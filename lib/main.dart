import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';  // Updated import statement
import 'package:provider/provider.dart';
import 'package:uidesginpage/pages/demo2.dart';
import 'package:uidesginpage/pages/demopage.dart';
import 'package:uidesginpage/pages/screens/contactpage.dart';
import 'package:uidesginpage/pages/screens/profilepage.dart';
import 'package:uidesginpage/pages/splashpage.dart';

Future<void> backroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print(" This is message from background");
  }
  if (kDebugMode) {
    print(message.notification!.title);
  }
  if (kDebugMode) {
    print(message.notification!.body);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Corrected import statement
  FirebaseMessaging.onBackgroundMessage(backroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>(
          initialData: null,
          create: (context) => FirebaseAuth.instance.authStateChanges(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: _checkConnectivity(),
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == ConnectivityResult.none) {
                return Scaffold(
                  body: Center(
                    child: Text('No internet connection'),
                  ),
                );
              } else {
                return MyProfilePage();
              }
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<ConnectivityResult> _checkConnectivity() async {
    return await Connectivity().checkConnectivity();
  }
}

