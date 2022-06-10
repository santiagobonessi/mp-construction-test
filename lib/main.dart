import 'package:flutter/material.dart';

import './pages/home_page.dart';
import './pages/new_diary_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Martin Pulgar App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xEDFFFFFF),
      ),
      home: const HomePage(title: 'Martin Pulgar Construction'),
      routes: {
        NewDiaryPage.routeName: (context) => const NewDiaryPage(),
      },
    );
  }
}
