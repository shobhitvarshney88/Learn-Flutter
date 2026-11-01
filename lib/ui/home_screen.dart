import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_flutter/ui/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  var url = "https://fake-json-api.mock.beeceptor.com/users";
  var data;

  final List<String> _items = [
    'Apple',
    'Banana',
    'Orange',
    'Grapes',
    'Mango',
    'Pineapple',
    'Strawberry',
    'Watermelon',
  ];

  List<String> get _filteredItems {
    if (_searchQuery.isEmpty) {
      return _items;
    } else {
      return _items
          .where(
            (item) => item.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var response = await http.get(Uri.parse(url));
    data = jsonDecode(response.body);
    print("API URL: $url");
    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    // print(data[0]['name']);
    for (var i = 0; i < data.length; i++) {
      print("name of $i is : ${data[i]['name']}");
    }
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Welcome Back, Demo!'),
      ),
      drawer: HomeDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search item...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _clearSearch();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(height: 16.0),

            Align(
              alignment: Alignment.centerLeft,
              child: Visibility(
                visible: _searchQuery.isNotEmpty && _filteredItems.isNotEmpty,
                child: Text(
                  '${_filteredItems.length} items found for "$_searchQuery"',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 16.0),

            Expanded(
              child: data.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(data[index]['name']),
                          subtitle: Text(data[index]['email']),
                          leading: Image.network(
                            data[index]['photo'],
                            width: 50,
                            height: 50,
                            webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error); // Display an error icon if the image fails to load
                            },
                          ), // Display the avatar image
                        );
                      },
                      itemCount: data.length,
                    )
                  : Center(child: Text('No items found for "$_searchQuery"')),
            ),
          ],
        ),
        // child: Text('Hello World', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed logic here
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
        ],
      ),
    );
  }
}
