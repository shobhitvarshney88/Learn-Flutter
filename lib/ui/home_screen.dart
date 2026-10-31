import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {

String _searchQuery = '';
final TextEditingController _searchController = TextEditingController();

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
    if(_searchQuery.isEmpty) {
      return _items;
    } else {
      return _items.where((item) => item.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
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
        title: Text('Search Item'),
      ),
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
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
              
                ),
              ),
            ),

            const SizedBox(height: 16.0),

            Align(
            
              alignment: Alignment.centerLeft,
              child: Visibility(
                visible: _searchQuery.isNotEmpty && _filteredItems.isNotEmpty,
                child: Text('${_filteredItems.length} items found for "$_searchQuery"',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            
              )
            ),

            const SizedBox(height: 16.0),

            Expanded(child: _filteredItems.isNotEmpty? 
            ListView.builder(itemBuilder: (context, index) {
              return ListTile(
                title: Text(_filteredItems[index]),
              );
            },
            itemCount: _filteredItems.length)
            : Center(child: Text('No items found for "$_searchQuery"'),)
            )
          ]
        
        )
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
      ),
    );
  }
}