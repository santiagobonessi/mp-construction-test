import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/home_page.dart';
import './pages/new_diary_page.dart';
import './providers/diaries.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Diaries(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MP Construction App',
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
