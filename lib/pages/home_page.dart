import 'package:flutter/material.dart';

import './new_diary_page.dart';
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
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: ButtonWidget(
          onPressed: () => Navigator.pushNamed(context, NewDiaryPage.routeName),
          title: 'Add New Diary',
        ),
      ),
    );
  }
}
