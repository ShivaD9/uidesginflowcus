import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uidesginpage/pages/screens/contactpage.dart';
import 'package:uidesginpage/pages/screens/profilepage.dart';
import 'package:uidesginpage/pages/screens/settingpage.dart';
import '../constants/constants.dart';
import 'demo2.dart';
import 'demopage.dart';
import 'loggedin.dart';
import '';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void navigateToPage(String pageName) {
    // Implement your navigation logic here
    // Example: Use Navigator.push to navigate to the specified page
    if (pageName == 'Assignments') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoggedIn()),
      );
    } else if (pageName == 'Attendence') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>   ContactPage()),
      );
    } else if (pageName == 'teachers \n Contact') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ContactPage()),
      );
    }
    else if (pageName == 'Setting') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  const SettingsScreen()),
      );
    } else if (pageName == 'profile') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>   MyProfilePage()),
      );
    }
    // Add more conditions for other pages
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'Hello Ahad!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Good Morning',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white54),
                  ),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/logo_flowcus.png'),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(200),
                ),
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard('Attendence', CupertinoIcons.graph_circle,
                      Colors.deepOrange),
                  itemDashboard(
                      'Assignments', CupertinoIcons.text_quote, Colors.green),
                  itemDashboard(
                      'teachers \n Contact', CupertinoIcons.person_2, Colors.purple),
                  itemDashboard(
                      'Events', CupertinoIcons.bubble_left, Colors.brown),
                  itemDashboard('School Fees', CupertinoIcons.money_dollar_circle,
                      Colors.indigo),
                  itemDashboard(
                      'class videos', CupertinoIcons.video_camera, Colors.teal),
                  itemDashboard(
                      'profile', CupertinoIcons.person, Colors.blue),
                  itemDashboard(
                      'Setting', CupertinoIcons.settings, Colors.pinkAccent),
                  // Add more items here
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget itemDashboard(String title, IconData iconData, Color background) {
    return GestureDetector(
      onTap: () {
        navigateToPage(title);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(title.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}

// Create separate page classes for each page you want to navigate to
class VideosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos'),
      ),
      body: const Center(
        child: Text('Videos Page'),
      ),
    );
  }
}

class AnalyticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: const Center(
        child: Text('Analytics Page'),
      ),
    );
  }
}



// Add more page classes for other pages
