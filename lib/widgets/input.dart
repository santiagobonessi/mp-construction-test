import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    Key? key,
    required this.placeholder,
    required this.controller,
    this.validator,
    this.tapFunction,
  }) : super(key: key);

  final String placeholder;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final dynamic tapFunction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        hintText: placeholder,
      ),
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.light,
      controller: controller,
      onTap: tapFunction,
    );
  }
}
