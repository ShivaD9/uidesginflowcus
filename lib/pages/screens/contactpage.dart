import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Map<String, dynamic>> dataList = [];
  List<Map<String, dynamic>> filteredList = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData(); // Call the method to fetch data from the API
  }

  Future<void> fetchData() async {
    final response =
    await http.get(Uri.parse('https://api.jsonbin.io/v3/b/6495da19b89b1e2299b3f2c8'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final teachers = data['record']['Teachers'];

      setState(() {
        dataList = List<Map<String, dynamic>>.from(teachers.map((teacher) {
          return {
            'imagePath': teacher['Image'],
            'name': teacher['TeachersName'].toString(),
            'subtitle': teacher['Designation'],
            'description': teacher['Description'],
            'mobilenumber': teacher['mobileNumber'],
            'whatsappnumber': teacher['WhatsAppNumber'],
            'email': teacher['email'],
            'isDropdownOpen': false,
          };
        }));

        // Copy the dataList to filteredList initially
        filteredList = List<Map<String, dynamic>>.from(dataList);
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch data from the API.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  void _toggleDropdownMenu(int index) {
    setState(() {
      dataList[index]['isDropdownOpen'] = !dataList[index]['isDropdownOpen'];
    });
  }

  void callPhoneNumber(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    final String phoneUrl = phoneUri.toString();
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Could not launch $phoneUrl';
    }
  }

  void openWhatsApp(String phoneNumber) async {
    final Uri whatsappUri = Uri.parse('https://wa.me/$phoneNumber');
    final String whatsappUrl = whatsappUri.toString();
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  void sendEmail(String emailAddress) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: emailAddress);
    final String emailUrl = emailUri.toString();
    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      throw 'Could not launch $emailUrl';
    }
  }

  void filterList(String query) {
    setState(() {
      // Clear the filteredList
      filteredList.clear();

      // If the query is empty, copy all items from dataList to filteredList
      if (query.isEmpty) {
        filteredList.addAll(dataList);
      } else {
        // Filter the dataList based on the query
        filteredList.addAll(dataList.where((item) {
          final name = item['name'].toLowerCase();
          final subtitle = item['subtitle'].toLowerCase();
          final description = item['description'].toLowerCase();
          return name.contains(query.toLowerCase()) ||
              subtitle.contains(query.toLowerCase()) ||
              description.contains(query.toLowerCase());
        }));
      }
    });
  }

  Future<void> _refreshData() async {
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers Contact'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(filteredList),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: filteredList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                buildListItem(
                  filteredList[index]['imagePath'],
                  filteredList[index]['name'],
                  filteredList[index]['subtitle'],
                  filteredList[index]['description'],
                  index,
                ),
                if (filteredList[index]['isDropdownOpen'])
                  buildDropdownMenu(filteredList[index]['name'], index),
                if (index != filteredList.length - 1)
                  const Divider(
                    thickness: 1.0,
                    indent: 100.0,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildListItem(String imagePath, String name, String subtitle, String description, int index) {
    return GestureDetector(
      onTap: () {
        _toggleDropdownMenu(index);
      },
      child: Container(
        height: 80.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80.0,
              height: double.infinity,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownMenu(String name, int index) {
    final String phoneNumber = dataList[index]['mobilenumber'];
    final String emailAddress = dataList[index]['email'];
    final String whatsapp = dataList[index]['whatsappnumber'];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.call),
            title: Text('Call $name'),
            onTap: () {
              callPhoneNumber(phoneNumber);
            },
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: Text('WhatsApp Message $name'),
            onTap: () {
              openWhatsApp(whatsapp);
            },
          ),
          ListTile(
            leading: const Icon(Icons.mail),
            title: Text('Mail $name'),
            onTap: () {
              sendEmail(emailAddress);
            },
          ),
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final List<Map<String, dynamic>> dataList;

  DataSearch(this.dataList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Filter the dataList based on the query
    final filteredList = dataList.where((item) {
      final name = item['name'].toLowerCase();
      final subtitle = item['subtitle'].toLowerCase();
      final description = item['description'].toLowerCase();
      return name.contains(query.toLowerCase()) ||
          subtitle.contains(query.toLowerCase()) ||
          description.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: filteredList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(filteredList[index]['name']),
          subtitle: Text(filteredList[index]['subtitle']),
          onTap: () {
            // Perform the action when a search result is tapped
            // For example, open the details page of the selected item
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types in the search field
    final suggestionList = dataList.where((item) {
      final name = item['name'].toLowerCase();
      final subtitle = item['subtitle'].toLowerCase();
      final description = item['description'].toLowerCase();
      return name.contains(query.toLowerCase()) ||
          subtitle.contains(query.toLowerCase()) ||
          description.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(suggestionList[index]['name']),
          subtitle: Text(suggestionList[index]['subtitle']),
          onTap: () {
            // Perform the action when a suggestion is tapped
            // For example, update the search field with the selected suggestion
            query = suggestionList[index]['name'];
          },
        );
      },
    );
  }
}

