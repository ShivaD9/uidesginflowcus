import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../constants/constants.dart';
import 'googleauth.dart';
import 'homepage.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();

  void _signInWithGoogle() async {
    try {
      await FirebaseServices().signInWithGoogle();
      _btnController.success();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    } catch (e) {
      _btnController.error();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.only(left: 40, right: 40, top: 90, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Image(
                      image: AssetImage(Config.app_icon),
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Welcome to \n Flowcus",
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w500,color: Colors.black,fontStyle: FontStyle.normal),),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Focus On their Flow.......... ",
                      style: TextStyle(fontSize: 15, color: Colors.black,fontStyle: FontStyle.italic),
                    ),
                    const Spacer(),
                    RoundedLoadingButton(
                      controller: _btnController,
                      color: primaryColor,
                      onPressed: _signInWithGoogle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          FaIcon(FontAwesomeIcons.google),
                          SizedBox(width: 10),
                          Text('Sign In With Google'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // rounded button
            ],
          ),
        ),
      ),
    );
  }
}



