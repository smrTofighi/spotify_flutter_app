import 'package:flutter/material.dart';

class AuthPrompt extends StatelessWidget {
  const AuthPrompt({
    super.key,
    required this.text,
    required this.buttonText,
    required this.page,
  });
  final String text;
  final String buttonText;
  final Widget page;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
