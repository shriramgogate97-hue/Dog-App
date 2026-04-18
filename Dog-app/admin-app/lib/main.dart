import 'package:flutter/material.dart';

void main() => runApp(const AdminApp());

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dog App',
      debugShowCheckedModeBanner: false,
      home: const AdminHomePage(),
      theme: ThemeData(colorSchemeSeed: Colors.blue),
    );
  }
}

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🛡️ Admin Mobile App')),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(child: Text('Admin Menu')),
            ListTile(title: Text('📊 Insights')),
            ListTile(title: Text('🏥 NGO Approvals')),
            ListTile(title: Text('⚠️ Incident Moderation')),
            ListTile(title: Text('⚙️ System Settings')),
          ],
        ),
      ),
      body: const Center(
        child: Text('Mobile oversight for rescue network operations.'),
      ),
    );
  }
}
