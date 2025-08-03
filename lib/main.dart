import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/homeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProjectName',
      theme: AppTheme.lightTheme(context),
      home: HomeScreen(),
    );
  }
}
