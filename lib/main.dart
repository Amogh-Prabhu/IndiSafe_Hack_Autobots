import 'package:flutter/material.dart';
import 'package:kavach/app/app.dart';
import 'package:kavach/login/layout/login_screen.dart';
import 'package:kavach/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kavach',
      home:  App()
    );
  }
}

