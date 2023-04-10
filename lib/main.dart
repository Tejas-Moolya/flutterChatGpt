import 'package:flutter/material.dart';
import 'package:hr_management_app/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Stress management",
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const ChatScreen(),
    );
  }
}
