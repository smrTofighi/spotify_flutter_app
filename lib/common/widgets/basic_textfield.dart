import 'package:flutter/material.dart';

class BasicTextfield extends StatelessWidget {
  const BasicTextfield({
    super.key,
    required this.hintText,
    this.type = TextInputType.text,
    required this.controller,
  });
  final String hintText;
  final TextInputType type;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
