import 'package:flutter/material.dart';

void main() => runApp(const CustomerApp());

class CustomerApp extends StatelessWidget {
  const CustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Dog App',
      debugShowCheckedModeBanner: false,
      home: const CustomerHomePage(),
      theme: ThemeData(colorSchemeSeed: Colors.orange),
    );
  }
}

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🐶 Customer Rescue App')),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(child: Text('Citizen Menu')),
            ListTile(title: Text('🚨 Raise SOS')),
            ListTile(title: Text('📍 Track Team')),
            ListTile(title: Text('🏆 Rewards')),
            ListTile(title: Text('🐕 Street Dog Profiles')),
          ],
        ),
      ),
      body: const Center(
        child: Text('Report injured animals quickly with photo/video + location.'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.sos),
        label: const Text('Emergency SOS'),
      ),
    );
  }
}
