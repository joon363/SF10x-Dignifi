import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'screens/homeScreen.dart';
import 'viewModels/taskViewModel.dart';
import 'package:vapi/vapi.dart';

void main() async{
  await VapiClient.platformInitialized.future;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskGroupViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dignifi',
        theme: AppTheme.lightTheme(context),
        home: HomeScreen(),
      ),
    );
  }
}
