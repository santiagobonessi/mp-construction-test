import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.onPressed, required this.title}) : super(key: key);

  final GestureTapCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.lightGreen,
          elevation: 20,
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
