import 'package:flutter/material.dart';

class NewDiaryPage extends StatefulWidget {
  static const routeName = '/new-diary';

  const NewDiaryPage({Key? key}) : super(key: key);

  @override
  State<NewDiaryPage> createState() => _NewDiaryPageState();
}

class _NewDiaryPageState extends State<NewDiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Diary'),
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
      ),
      body: const Center(
        child: Text('TODO: NEW DIARY FUNCTIONALITY'),
      ),
    );
  }
}
