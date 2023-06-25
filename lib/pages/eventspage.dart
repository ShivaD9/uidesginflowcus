import 'package:flutter/material.dart';

import '../constants/constants.dart';



class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Example'),
      backgroundColor: primaryColor,),
      body: ListView.builder(
        itemCount: 5, // Number of cards you want to display
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail');
            },
            child: Card(
              margin: const EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: primaryColor),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 100, // Increase the height of the card
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 100,
                      child: Image.asset(
                        "assets/logo_flowcus.png", // Replace with your image asset path
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Title'),
                          SizedBox(width: 10),
                          Text(
                            'Subtitle',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Description',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Page')),
      body: const Center(child: Text('This is the detail page.')),
    );
  }
}


