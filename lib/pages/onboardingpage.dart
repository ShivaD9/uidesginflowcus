import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uidesginpage/pages/slider.dart';
import '../constants/constants.dart';
import 'homepage.dart';
import 'loginpage.dart';


class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({super.key});

  @override
  _onBoardingScreenState createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  int _currentPage = 0;
  final PageController _controller = PageController();

  final List<Widget> _pages = [
    const SliderPage(
      title: "Attendance track",
      description:
      "Flowcus is a productivity app that offers Attendance tracking and Analysis on Student Performance.",
      image: "assets/onboard1.png",
    ),
    const SliderPage(
      title: "Assignments",
      description:
      "Flowcus offers a task management feature that enables users to create, organize, and prioritize their tasks and assignments.",
      image: "assets/onboard2.png",
    ),
    const SliderPage(
      title: "Announcement",
      description:
      "Flowcus app does have a specific feature for announcing events.",
      image: "assets/onboard3.png",
    ),
  ];

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MyHomePage();
        } else {
          return Scaffold(
            body: Stack(
              children: <Widget>[
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  onPageChanged: _onchanged,
                  controller: _controller,
                  itemCount: _pages.length,
                  itemBuilder: (context, int index) {
                    return _pages[index];
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        List<Widget>.generate(_pages.length, (int index) {
                          return AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              height: 10,
                              width: (index == _currentPage) ? 30 : 10,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: (index == _currentPage)
                                      ?  primaryColor
                                      :  primaryColor
                                      .withOpacity(0.5)));
                        })),
                    InkWell(
                      onTap: () {
                        if (_currentPage == (_pages.length - 1)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage()),
                          );
                        } else {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeInOutQuint);
                        }
                      },
                      child: AnimatedContainer(
                        alignment: Alignment.center,
                        duration: const Duration(milliseconds: 300),
                        height: 70,
                        width: (_currentPage == (_pages.length - 1)) ? 200 : 75,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(35)),
                        child: (_currentPage == (_pages.length - 1))
                            ? const Text(
                          "Get Started",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )
                            : const Icon(
                          Icons.navigate_next,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
