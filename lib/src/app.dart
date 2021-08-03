import 'package:flutter/material.dart';
import 'package:save_your_secrets/src/pages/pages.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Save your Secrets',
      initialRoute: 'login',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[200]
      ),
      routes: {
        'login': (_) => LoginPage(),
        'home': (_) => HomePage(),
        'creation': (_) => SecretCreationPage(),
      },
    );
  }
}