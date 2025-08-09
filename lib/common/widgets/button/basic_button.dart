import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  const BasicButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
  });
  final VoidCallback onPressed;
  final String title;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 80,
      child: ElevatedButton(
        onPressed: onPressed,
       
        child: Text(title, style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
