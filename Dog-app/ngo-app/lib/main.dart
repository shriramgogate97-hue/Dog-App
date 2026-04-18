import 'package:flutter/material.dart';

void main() => runApp(const NgoApp());

class NgoApp extends StatelessWidget {
  const NgoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NGO Rescue App',
      debugShowCheckedModeBanner: false,
      home: const NgoHomePage(),
      theme: ThemeData(colorSchemeSeed: Colors.green),
    );
  }
}

class NgoHomePage extends StatelessWidget {
  const NgoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🚑 NGO Dispatch App')),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(child: Text('NGO Operations')),
            ListTile(title: Text('📥 New Incidents')),
            ListTile(title: Text('🛰️ Live Tracking')),
            ListTile(title: Text('👨‍⚕️ Rescue Team Status')),
            ListTile(title: Text('✅ Case Closure')),
          ],
        ),
      ),
      body: const Center(
        child: Text('Accept incidents and update rescue ETA in real time.'),
      ),
    );
  }
}
