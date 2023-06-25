import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'googleauth.dart';
import 'loginpage.dart';


final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class LoggedIn extends StatelessWidget {
  const LoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009D85),
        title: const Text("Google SignIn"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60.0,
              backgroundImage: NetworkImage("${FirebaseAuth.instance.currentUser!.photoURL}"),
            ),
            const SizedBox(height: 20.0),
            const Text("Logged in as:", style: TextStyle(fontSize: 20.0)),
            const SizedBox(height: 5.0),
            Text("${FirebaseAuth.instance.currentUser!.email?.split('@')[0]}@host.com", style: const TextStyle(fontSize: 18.0)),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseServices().googleSignOut();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()));
                  }
                } catch (e) {
                  print('Error: $e');
                }
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF009D85),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("LogOut", style: TextStyle(fontSize: 18.0)),
            ),
          ],
        ),
      ),
    );
  }
}
