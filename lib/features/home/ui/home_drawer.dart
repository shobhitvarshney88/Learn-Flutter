import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Shobhit Varshney"),
              accountEmail: Text("shobhit.varshney@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://picsum.photos/200"),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              leading: Icon(Icons.home),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 16),
            
              onTap: () {
                // Handle item 1 tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 16),
              onTap: () {
                // Handle item 2 tap
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
  }
}