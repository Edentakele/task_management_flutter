import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      // Set HomeScreen as the initial route
      home: HomeScreen(),
      // Optionally, you can remove the home parameter and set the HomeScreen directly
      // home: HomeScreen(),
    );
  }
}
