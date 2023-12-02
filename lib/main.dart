import 'package:flutter/material.dart';
import 'package:target/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Target Sistemas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff44bd6e),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
