import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_app/core/themes/app_colors.dart';

class DarkModeToggleMode extends StatelessWidget {
  const DarkModeToggleMode({super.key, required this.title, required this.icon, required this.onTap});
  final String title;
  final String icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF30393C).withAlpha(127),
                ),
                child: SvgPicture.asset(icon, fit: BoxFit.none),
              ),
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
