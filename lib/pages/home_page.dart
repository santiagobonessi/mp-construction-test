import 'package:flutter/material.dart';

import './new_diary_page.dart';
import '../widgets/app_bar.dart';
import '../widgets/button.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Martin Pulgar Construction'),
      body: Center(
        child: ButtonWidget(
          onPressed: () => Navigator.pushNamed(context, NewDiaryPage.routeName),
          title: 'Add New Diary',
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }
}
