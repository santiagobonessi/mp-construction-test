import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.onPressed,
    required this.title,
    this.padding,
  }) : super(key: key);

  final GestureTapCallback onPressed;
  final String title;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      padding: padding,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 20,
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
